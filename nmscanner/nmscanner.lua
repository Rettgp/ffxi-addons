_addon.name = 'nmscanner'
_addon.author = 'Rett'
_addon.version = '1.4'
_addon.commands = {'nmscan', 'nmscanner'}

require('luau')
require('ffxi')
local nm_database = require('nm_database')
local ui = require('ui')

-- Configuration
local config = {
    enabled = true,
    scan_interval = 1.0,  -- seconds between scans
    show_ui = true,
    max_distance = 500,  -- yalms - only alert for NMs within this distance
    alert_sound = true,
    validate_zone = true  -- Only alert for NMs in the current zone
}

-- Tracking
local detected_nms = {}  -- Cache to avoid repeat alerts
local active_nms = {}    -- Currently tracked NMs with live data
local blacklisted_nms = {} -- Dismissed NMs that won't show again until zone change
local last_scan_time = 0
local scan_active = false
local current_zone_id = 0  -- Track zone changes

-- Logging function
function log(msg)
    local prefix = 'NM Scanner: '
    local color  = 204
    
    if type(msg) == 'table' then
        for _, line in ipairs(msg) do
            windower.add_to_chat(color, prefix .. line)
        end
    else
        windower.add_to_chat(color, prefix .. msg)
    end
end

-- Calculate distance between two points
local function calculate_distance(x1, y1, z1, x2, y2, z2)
    local dx = x2 - x1
    local dy = y2 - y1
    local dz = z2 - z1
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

-- Get player position
local function get_player_position()
    local player = windower.ffxi.get_player()
    if player then
        local mob = windower.ffxi.get_mob_by_target('me')
        if mob then
            return mob.x, mob.y, mob.z
        end
    end
    return 0, 0, 0
end

-- Get current zone name
local function get_current_zone()
    local info = windower.ffxi.get_info()
    if info and info.zone then
        return res.zones[info.zone].en
    end
    return nil
end

-- Scan for NMs in the mob array
local function scan_for_nms()
    if not config.enabled then return end
    
    local current_time = os.clock()
    if current_time - last_scan_time < config.scan_interval then
        return
    end
    
    last_scan_time = current_time
    local player_x, player_y, player_z = get_player_position()
    local current_zone = get_current_zone()
    
    local found_nms = {}  -- Track NMs found in this scan
    
    -- Scan through all mobs (index is mob.index in zone, not mob.id)
    for index, mob in pairs(ffxi.mob_array) do
        if mob and mob.name then  -- 16 = mob
            -- Check if this is an NM
            if nm_database.is_nm(mob.name) then
                -- Get NM details from database
                local nm_details = nm_database.get_details(mob.name)
                
                -- Validate zone if enabled
                if config.validate_zone and current_zone and nm_details and nm_details.zone and nm_details.zone == current_zone then
                    -- Calculate distance
                    local distance = calculate_distance(
                        player_x, player_y, player_z,
                        mob.x or 0, mob.y or 0, mob.z or 0
                    )
                    
                    -- Check if within alert range, not blacklisted, and alive (hpp > 0)
                    if distance <= config.max_distance and not blacklisted_nms[mob.id] and (mob.hpp or 0) > 0 then
                        found_nms[mob.id] = true
                        
                        -- Prepare notification data
                        local nm_data = {
                            name = mob.name,
                            level = nm_details and nm_details.level or '??',
                            family = nm_details and nm_details.family or 'Unknown',
                            zone = nm_details and nm_details.zone or 'Current Zone',
                            distance = distance,
                            hpp = mob.hpp or 100,
                            mob_id = mob.id
                        }
                        
                        -- If new NM, show initial alert and play sound
                        if not detected_nms[mob.id] then
                            detected_nms[mob.id] = {
                                time = current_time,
                                name = mob.name
                            }
                            
                            -- Play alert sound
                            if config.alert_sound then
                                windower.play_sound(windower.addon_path .. 'alert.wav')
                            end
                        end
                        
                        -- Track as active NM
                        active_nms[mob.id] = {
                            data = nm_data,
                            last_update = current_time
                        }
                        
                        -- Update UI with current data
                        if config.show_ui then
                            ui.update_nm(nm_data)
                        end
                    end
                end
            end
        end
    end
    
    -- Remove NMs that are no longer in range or don't exist
    for id, nm_info in pairs(active_nms) do
        if not found_nms[id] then
            active_nms[id] = nil
            -- If this was the displayed NM, hide UI
            if ui.is_showing() and ui.current_nm and ui.current_nm.mob_id == id then
                ui.hide()
            end
        end
    end
    
    -- Clean up old detections (after 5 minutes)
    for id, detection in pairs(detected_nms) do
        if current_time - detection.time > 300 then
            detected_nms[id] = nil
        end
    end
end

-- Initialize addon
windower.register_event('load', function()
    log('NM Scanner loaded! Monitoring for notorious monsters...')
    log(string.format('Database contains %d NMs', nm_database.get_count()))
    
    ui.initialize()
    scan_active = true
end)

-- Unload cleanup
windower.register_event('unload', function()
    scan_active = false
    ui.destroy()
end)

-- Main update loop
windower.register_event('prerender', function()
    if scan_active then
        scan_for_nms()
        ui.update()  -- Update for pulsing effect
    end
end)

-- Zone change handler - clear blacklist
windower.register_event('zone change', function(new_id, old_id)
    blacklisted_nms = {}
    detected_nms = {}
    active_nms = {}
    current_zone_id = new_id
    ui.hide()
end)

-- Mouse click handler to dismiss UI and blacklist NM
windower.register_event('mouse', function(type, x, y, delta, blocked)
    if type == 5 and ui.is_showing() then  -- Right click (type 5) to dismiss
        if ui.display then
            local pos_x = ui.display:pos_x()
            local pos_y = ui.display:pos_y()
            
            -- Approximate UI bounds (adjust as needed)
            local ui_width = 450
            local ui_height = 150
            
            if x >= pos_x and x <= pos_x + ui_width and
               y >= pos_y and y <= pos_y + ui_height then
                -- Add current NM to blacklist
                if ui.current_nm and ui.current_nm.mob_id then
                    blacklisted_nms[ui.current_nm.mob_id] = true
                end
                ui.hide()
                return true  -- Block the click from passing through
            end
        end
    end
    return false
end)

-- Command handling
windower.register_event('addon command', function(command, ...)
    command = (command or 'help'):lower()
    local params = {...}

    if command == 'help' then
        log({
            'NM Scanner Commands:',
            '  //nmscan help - Show this help message',
            '  //nmscan toggle - Toggle scanner on/off',
            '  //nmscan ui - Toggle UI notifications',
            '  //nmscan sound - Toggle alert sound',
            '  //nmscan zone - Toggle zone validation',
            '  //nmscan distance <yalms> - Set max alert distance',
            '  //nmscan theme <dark|blue|purple|red> - Change UI theme',
            '  //nmscan clear - Clear detected NM cache',
            '  //nmscan status - Show current settings',
            '  //nmscan list <name> - Check if a mob is in NM database',
            '  //nmscan test <mob_id> - Test notification with specific mob ID'
        })
    elseif command == 'toggle' then
        config.enabled = not config.enabled
        log(string.format('NM Scanner %s', config.enabled and '\\cs(100,255,100)ENABLED\\cr' or '\\cs(255,100,100)DISABLED\\cr'))
    elseif command == 'ui' then
        config.show_ui = not config.show_ui
        log(string.format('UI notifications %s', config.show_ui and '\\cs(100,255,100)ON\\cr' or '\\cs(255,100,100)OFF\\cr'))
    elseif command == 'sound' then
        config.alert_sound = not config.alert_sound
        log(string.format('Alert sound %s', config.alert_sound and '\\cs(100,255,100)ON\\cr' or '\\cs(255,100,100)OFF\\cr'))
    elseif command == 'zone' then
        config.validate_zone = not config.validate_zone
        log(string.format('Zone validation %s', config.validate_zone and '\\cs(100,255,100)ON\\cr' or '\\cs(255,100,100)OFF\\cr'))
    elseif command == 'distance' then
        local distance = tonumber(params[1])
        if distance and distance > 0 then
            config.max_distance = distance
            log(string.format('Alert distance set to %.1f yalms', distance))
        else
            log('Usage: //nmscan distance <yalms>')
        end
    elseif command == 'theme' then
        local theme = (params[1] or 'red'):lower()
        if theme == 'dark' or theme == 'blue' or theme == 'purple' or theme == 'red' then
            ui.set_theme(theme)
            log(string.format('UI theme set to: \\cs(100,255,100)%s\\cr', theme))
        else
            log('Usage: //nmscan theme <dark|blue|purple|red>')
        end
    elseif command == 'clear' then
        detected_nms = {}
        blacklisted_nms = {}
        log('Detected NM cache and blacklist cleared')
    elseif command == 'status' then
        log({
            'NM Scanner Status:',
            string.format('  Scanner: %s', config.enabled and '\\cs(100,255,100)ENABLED\\cr' or '\\cs(255,100,100)DISABLED\\cr'),
            string.format('  UI Notifications: %s', config.show_ui and 'ON' or 'OFF'),
            string.format('  Alert Sound: %s', config.alert_sound and 'ON' or 'OFF'),
            string.format('  Zone Validation: %s', config.validate_zone and 'ON' or 'OFF'),
            string.format('  Max Distance: %.1f yalms', config.max_distance),
            string.format('  Current Zone: %s', get_current_zone() or 'Unknown'),
            string.format('  NMs in Database: %d', nm_database.get_count()),
            string.format('  Currently Detected: %d', table.length(detected_nms)),
            string.format('  Blacklisted (Dismissed): %d', table.length(blacklisted_nms))
        })
    elseif command == 'list' then
        local search_name = table.concat(params, ' ')
        if search_name and search_name ~= '' then
            if nm_database.is_nm(search_name) then
                local details = nm_database.get_details(search_name)
                log({
                    string.format('\\cs(100,255,100)%s IS an NM\\cr', search_name),
                    string.format('  Level: %s', details.level or '??'),
                    string.format('  Family: %s', details.family or 'Unknown'),
                    string.format('  Zone: %s', details.zone or 'Unknown')
                })
            else
                log(string.format('\\cs(255,100,100)%s is NOT in the NM database\\cr', search_name))
            end
        else
            log('Usage: //nmscan list <monster name>')
        end
    elseif command == 'test' then
        local mob_id = tonumber(params[1])
        if mob_id then
            local mob = ffxi.mob_array[mob_id]
            
            if mob and mob.name then
                local player_x, player_y, player_z = get_player_position()
                local distance = calculate_distance(
                    player_x, player_y, player_z,
                    mob.x or 0, mob.y or 0, mob.z or 0
                )
                
                -- Check if mob is actually an NM in database
                local nm_details = nm_database.get_details(mob.name)
                local is_real_nm = nm_database.is_nm(mob.name)
                
                -- Create test notification data
                local nm_data = {
                    name = mob.name,
                    level = nm_details and nm_details.level or '??',
                    family = nm_details and nm_details.family or 'Test',
                    zone = nm_details and nm_details.zone or 'Test Zone',
                    distance = distance,
                    hpp = mob.hpp or 100,
                    mob_id = mob.id
                }
                
                -- Show notification
                if config.show_ui then
                    ui.show_nm(nm_data)
                end
            else
                log(string.format('\\cs(255,100,100)Mob ID %d not found in mob array\\cr', mob_id))
            end
        else
            log('Usage: //nmscan test <mob_id>')
        end
    else
        log(string.format('Unknown command: %s (use //nmscan help)', command))
    end
end)