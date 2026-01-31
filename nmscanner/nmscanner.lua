_addon.name = 'nmscanner'
_addon.author = 'Rett'
_addon.version = '1.7'
_addon.commands = {'nmscan', 'nmscanner'}

require('luau')
require('ffxi')
local nm_database = require('nm_database')
local ui = require('ui')
local packets = require('packets')
require('utils')

-- Configuration
local config = {
    enabled = true,
    scan_interval = 2.0,  -- seconds between scans (reduced CPU load)
    show_ui = true,
    max_distance = 500,  -- yalms - only alert for NMs within this distance
    alert_sound = true,
    validate_zone = true,  -- Only alert for NMs in the current zone
    debug = false,  -- Enable debug logging
    widescan_monitor = true,  -- Monitor Wide Scan for distant NMs
    auto_widescan = false,  -- Automatically use Wide Scan
    auto_widescan_interval = 5  -- Seconds between auto Wide Scans
}

-- Tracking
local detected_nms = {}  -- Cache to avoid repeat alerts
local active_nms = {}    -- Currently tracked NMs with live data
local blacklisted_nms = {} -- Dismissed NMs that won't show again until zone change
local pending_pop_requests = {}  -- NM indices waiting for mob_array population
local last_scan_time = 0
local scan_active = true  -- Start scanning immediately
local current_zone_id = 0  -- Track zone changes
local last_widescan_time = 0  -- Track when we last used Wide Scan
local last_ui_update = 0  -- Track UI update throttling
local last_pop_check = 0  -- Track pending pop request checks
local ui_needs_update = false  -- Flag if UI needs updating

-- Logging function
function log(msg)
    local prefix = string.char(31, 204) .. '[NM Scanner] ' .. string.char(31, 1)
    
    if type(msg) == 'table' then
        for _, line in ipairs(msg) do
            windower.add_to_chat(1, prefix .. line)
        end
    else
        windower.add_to_chat(1, prefix .. msg)
    end
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
    if not config.enabled then 
        return 
    end
    
    local current_time = os.clock()
    if current_time - last_scan_time < config.scan_interval then
        return
    end
    
    last_scan_time = current_time
    local player_x, player_y, player_z = get_player_position()
    local current_zone = get_current_zone()
    
    if nm_database.get_zone_nm_count(current_zone) == 0 then
        return
    end
    
    local found_nms = {}  -- Track NMs found in this scan
    local scanned_count = 0
    local nm_count = 0
    
    -- Scan through all mobs (index is mob.index in zone, not mob.id)
    for index, mob in pairs(ffxi.mob_array) do
        scanned_count = scanned_count + 1
        if mob and mob.name then
            if nm_database.is_nm(mob.name, current_zone) then
                nm_count = nm_count + 1
                if mob.pos ~= nil then
                    if config.debug then
                        log(string.format('Found NM: %s (ID: %s, Index: %s)', mob.name, tostring(mob.id), tostring(index)))
                    end
                    
                    local nm_details = nm_database.get_details(mob.name)
                    
                    -- Validate zone if enabled
                    local zone_check_passed = not config.validate_zone or 
                        (current_zone and nm_details and nm_details.zone and nm_details.zone == current_zone)
                    
                    if config.debug then
                        log(string.format('  Zone check: %s (validate_zone=%s, current=%s, expected=%s)', 
                            tostring(zone_check_passed), tostring(config.validate_zone), 
                            tostring(current_zone), nm_details and nm_details.zone or 'nil'))
                    end
                    
                    if zone_check_passed then
                        local distance = utils.distance_to_mob(index)
                        
                        -- Check if within alert range, not blacklisted, and alive (hpp > 0 or nil for just-spawned mobs)
                        if distance <= config.max_distance and not blacklisted_nms[mob.id] and (mob.hpp == nil or mob.hpp > 0) then
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
                            
                            if not detected_nms[mob.id] then
                                detected_nms[mob.id] = {
                                    time = current_time,
                                    name = mob.name
                                }
                                
                                if config.alert_sound then
                                    windower.play_sound(windower.addon_path .. 'alert.wav')
                                end
                            end
                            
                            active_nms[mob.id] = {
                                data = nm_data,
                                last_update = current_time
                            }
                            ui_needs_update = true
                            
                            if config.show_ui then
                                ui.update_nm(nm_data)
                            end
                        else
                            if config.debug then
                                log(string.format('  NM not alerted: distance_ok=%s, not_blacklisted=%s, alive=%s',
                                    tostring(distance <= config.max_distance),
                                    tostring(not blacklisted_nms[mob.id]),
                                    tostring(mob.hpp == nil or mob.hpp > 0)))
                            end
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
            ui_needs_update = true
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
    
    if config.debug then
        log(string.format('Scan complete - Checked: %d mobs, Found: %d NMs, Detected: %d new', 
            scanned_count, nm_count, table.length(found_nms)))
    end
end

-- Initialize addon
windower.register_event('load', function()
    log('Monitoring for notorious monsters...')
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
    -- Early exit if scanner not active or disabled
    if not scan_active or not config.enabled then
        return
    end
    
    local current_time = os.clock()
    
    -- Run main NM scan (internally throttled by scan_interval)
    scan_for_nms()
    
    -- Throttle UI updates to 10 FPS (0.1 second intervals)
    if ui_needs_update and current_time - last_ui_update >= 0.1 then
        ui.update()
        ui_needs_update = false
        last_ui_update = current_time
    end
    
    -- Check pending pop requests every 0.5 seconds instead of every frame
    if current_time - last_pop_check >= 0.5 then
        last_pop_check = current_time
        
        for index, request_info in pairs(pending_pop_requests) do
            local mob = ffxi.mob_array[index]
            if mob and type(mob) == 'table' then
                pending_pop_requests[index] = nil
            else
                if current_time - request_info.last_request >= 2 then  -- Retry every 2 seconds
                    utils.request_pop(index)
                    request_info.attempts = request_info.attempts + 1
                    request_info.last_request = current_time
                    
                    -- Give up after 5 attempts (10 seconds)
                    if request_info.attempts >= 5 then
                        pending_pop_requests[index] = nil
                    end
                end
            end
        end
    end
    
    -- Auto Wide Scan - only check when interval might have elapsed
    if config.auto_widescan and config.widescan_monitor then
        local current_zone = get_current_zone()
        
        if nm_database.get_zone_nm_count(current_zone) > 0 then
            -- Only check widescan timing if enough time has passed (min interval / 3)
            if current_time - last_widescan_time >= (config.auto_widescan_interval / 3) then
                -- Random interval between 1/3 and full interval
                local random_interval = math.random(config.auto_widescan_interval / 3 * 100, config.auto_widescan_interval * 100) / 100
                if current_time - last_widescan_time >= random_interval then
                    last_widescan_time = current_time
                    
                    -- Inject Wide Scan packet (0x0F4)
                    local player = windower.ffxi.get_player()
                    if player then
                        local packet = packets.new('outgoing', 0x0F4)
                        packets.inject(packet)
                    end
                end
            end
        end
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

-- Wide Scan packet handler (0x0F4) - request mob data for NMs
windower.register_event('incoming chunk', function(id, data)
    if not config.enabled or not config.widescan_monitor then return end
    
    if id == 0x0F4 then  -- Wide Scan packet
        local current_zone = get_current_zone()
        if nm_database.get_zone_nm_count(current_zone) == 0 then
            return
        end
        
        local packet = packets.parse('incoming', data)
        local name = packet['Name']
        local index = packet['Index']
        
        -- Validate index is actually a number
        if name and name ~= '' and index and type(index) == 'number' and index > 0 then
            if nm_database.is_nm(name, current_zone) then
                if not ffxi.mob_array[index] and not pending_pop_requests[index] then
                    pending_pop_requests[index] = {
                        name = name,
                        attempts = 0,
                        last_request = 0
                    }
                end
            end
        end
    end
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
            '  //nmscan widescan - Toggle Wide Scan monitoring',
            '  //nmscan auto - Toggle automatic Wide Scan',
            '  //nmscan interval <seconds> - Set auto Wide Scan interval',
            '  //nmscan debug - Toggle debug logging',
            '  //nmscan distance <yalms> - Set max alert distance',
            '  //nmscan clear - Clear detected NM cache',
            '  //nmscan status - Show current settings',
            '',
            'Testing Commands:',
            '  //nmscan mobs - List all mobs in current zone',
            '  //nmscan scan - Force an immediate scan',
            '  //nmscan find <name> - Find mob by name in mob array',
            '  //nmscan addtest <name> - Temporarily add a mob to NM database',
            '  //nmscan list <name> - Check if a mob is in NM database',
            '  //nmscan test <index> - Test notification with mob by index'
        })
    elseif command == 'toggle' then
        config.enabled = not config.enabled
        log(string.format('NM Scanner %s', config.enabled and 'ENABLED' or 'DISABLED'))
    elseif command == 'ui' then
        config.show_ui = not config.show_ui
        log(string.format('UI notifications %s', config.show_ui and 'ON' or 'OFF'))
    elseif command == 'sound' then
        config.alert_sound = not config.alert_sound
        log(string.format('Alert sound %s', config.alert_sound and 'ON' or 'OFF'))
    elseif command == 'zone' then
        config.validate_zone = not config.validate_zone
        log(string.format('Zone validation %s', config.validate_zone and 'ON' or 'OFF'))
    elseif command == 'widescan' then
        config.widescan_monitor = not config.widescan_monitor
        log(string.format('Wide Scan monitoring %s', config.widescan_monitor and 'ON' or 'OFF'))
    elseif command == 'auto' then
        config.auto_widescan = not config.auto_widescan
        log(string.format('Auto Wide Scan %s', config.auto_widescan and 'ON' or 'OFF'))
        if config.auto_widescan then
            log(string.format('Will cast Wide Scan every %d seconds', config.auto_widescan_interval))
        end
    elseif command == 'interval' then
        local interval = tonumber(params[1])
        if interval and interval >= 5 then
            config.auto_widescan_interval = interval
            log(string.format('Auto Wide Scan interval set to %d seconds', interval))
        else
            log('Usage: //nmscan interval <seconds> (minimum 5)')
        end
    elseif command == 'debug' then
        config.debug = not config.debug
        log(string.format('Debug mode %s', config.debug and 'ON' or 'OFF'))
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
            log(string.format('UI theme set to: %s', theme))
        else
            log('Usage: //nmscan theme <dark|blue|purple|red>')
        end
    elseif command == 'mobs' then
        local count = 0
        local player_x, player_y, player_z = get_player_position()
        log('Current mobs in zone:')
        for index, mob in pairs(ffxi.mob_array) do
            if mob and mob.name then
                count = count + 1
                local distance = utils.distance_to_mob(index)
                local is_nm = nm_database.is_nm(mob.name) and '[NM]' or ''
                log(string.format('  [%d] %s %s- Dist: %.1f, HPP: %s, ID: %s', 
                    index, mob.name, is_nm, distance, tostring(mob.hpp), tostring(mob.id)))
            end
        end
        log(string.format('Total: %d valid mobs', count))
    elseif command == 'scan' then
        log('Forcing immediate scan...')
        last_scan_time = 0  -- Reset timer to force scan
        scan_for_nms()
        log('Scan complete')
    elseif command == 'find' then
        local search_name = table.concat(params, ' '):lower()
        if search_name and search_name ~= '' then
            local found = false
            local player_x, player_y, player_z = get_player_position()
            for index, mob in pairs(ffxi.mob_array) do
                if mob and mob.name and mob.name:lower():find(search_name, 1, true) then
                    found = true
                    local distance = utils.distance_to_mob(index)
                    local pos_str = 'NIL'
                    if mob.pos and #mob.pos == 3 then
                        pos_str = string.format('(%.1f, %.1f, %.1f)', mob.pos[1], mob.pos[3], mob.pos[2])
                    end
                    local valid = mob.valid_target and 'VALID' or 'INVALID'
                    local is_nm = nm_database.is_nm(mob.name) and '[NM]' or ''
                    log(string.format('[%d] %s %s', index, mob.name, is_nm))
                    log(string.format('  Status: %s, Distance: %.1f, HPP: %s', valid, distance, tostring(mob.hpp)))
                    log(string.format('  ID: %s, Pos: %s', tostring(mob.id), pos_str))
                end
            end
            if not found then
                log(string.format('No mobs found matching "%s"', search_name))
            end
        else
            log('Usage: //nmscan find <partial name>')
        end
    elseif command == 'addtest' then
        local test_name = table.concat(params, ' ')
        if test_name and test_name ~= '' then
            local current_zone = get_current_zone()
            local zone = current_zone or 'Test Zone'
            
            nm_database.nm_set[test_name:lower()] = true
            nm_database.nm_details[test_name:lower()] = {
                name = test_name,
                zone = zone,
                level = 99,
                family = 'Test'
            }
            
            if not nm_database.by_zone[zone] then
                nm_database.by_zone[zone] = {}
            end
            nm_database.by_zone[zone][test_name:lower()] = true
            
            log(string.format('Added "%s" as temporary test NM', test_name))
            log(string.format('Zone: %s', zone))
            log('Use //nmscan find to locate it in the mob array')
            log('Note: This will reset when addon reloads')
        else
            log('Usage: //nmscan addtest <mob name>')
        end
    elseif command == 'clear' then
        detected_nms = {}
        blacklisted_nms = {}
        log('Detected NM cache and blacklist cleared')
    elseif command == 'status' then
        log({
            'NM Scanner Status:',
            string.format('  Scanner: %s', config.enabled and 'ENABLED' or 'DISABLED'),
            string.format('  Scan Active: %s', scan_active and 'YES' or 'NO'),
            string.format('  Last Scan: %.1f seconds ago', os.clock() - last_scan_time),
            string.format('  UI Notifications: %s', config.show_ui and 'ON' or 'OFF'),
            string.format('  Alert Sound: %s', config.alert_sound and 'ON' or 'OFF'),
            string.format('  Zone Validation: %s', config.validate_zone and 'ON' or 'OFF'),
            string.format('  Wide Scan Monitor: %s', config.widescan_monitor and 'ON' or 'OFF'),
            string.format('  Auto Wide Scan: %s', config.auto_widescan and 'ON' or 'OFF'),
            string.format('  Auto Scan Interval: %d seconds', config.auto_widescan_interval),
            string.format('  Next Wide Scan: %.1f seconds', math.max(0, config.auto_widescan_interval - (os.clock() - last_widescan_time))),
            string.format('  Debug Mode: %s', config.debug and 'ON' or 'OFF'),
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
                    string.format('%s IS an NM', search_name),
                    string.format('  Level: %s', details.level or '??'),
                    string.format('  Family: %s', details.family or 'Unknown'),
                    string.format('  Zone: %s', details.zone or 'Unknown')
                })
            else
                log(string.format('%s is NOT in the NM database', search_name))
            end
        else
            log('Usage: //nmscan list <monster name>')
        end
    elseif command == 'test' then
        local mob_index = tonumber(params[1])
        if mob_index then
            local mob = ffxi.mob_array[mob_index]
            local w_mob = windower.ffxi.get_mob_by_index(mob_index)
            
            if mob or w_mob then
                log(string.format('Testing mob at index %d:', mob_index))
                
                -- Show both data sources
                if mob then
                    log(string.format('  Custom mob_array data:'))
                    log(string.format('    Name: %s', mob.name or 'NIL'))
                    log(string.format('    Valid Target: %s', tostring(mob.valid_target)))
                    if mob.pos and #mob.pos == 3 then
                        log(string.format('    Position: (%.1f, %.1f, %.1f)', mob.pos[1], mob.pos[3], mob.pos[2]))
                    else
                        log(string.format('    Position: NIL'))
                    end
                    log(string.format('    HPP: %s', tostring(mob.hpp)))
                    log(string.format('    ID: %s', tostring(mob.id)))
                end
                
                if w_mob then
                    log(string.format('  Windower mob data:'))
                    log(string.format('    Name: %s', w_mob.name or 'NIL'))
                    log(string.format('    Valid Target: %s', tostring(w_mob.valid_target)))
                    log(string.format('    Position: (%.1f, %.1f, %.1f)', w_mob.x or 0, w_mob.y or 0, w_mob.z or 0))
                    log(string.format('    HPP: %s', tostring(w_mob.hpp)))
                    log(string.format('    ID: %s', tostring(w_mob.id)))
                end
                
                local name = (mob and mob.name) or (w_mob and w_mob.name)
                local valid_target = (mob) or (w_mob)
                
                -- Extract position from mob.pos table
                local pos_x, pos_y, pos_z
                if mob and mob.pos and #mob.pos == 3 then
                    pos_x = mob.pos[1]  -- X
                    pos_z = mob.pos[2]  -- Z (height)
                    pos_y = mob.pos[3]  -- Y
                elseif w_mob then
                    pos_x = w_mob.x
                    pos_y = w_mob.y
                    pos_z = w_mob.z
                end
                
                local hpp = (mob and mob.hpp) or (w_mob and w_mob.hpp)
                local id = (mob and mob.id) or (w_mob and w_mob.id)
                
                if name then
                    local is_nm = nm_database.is_nm(name)
                    log(string.format('  In NM Database: %s', is_nm and 'YES' or 'NO'))
                    
                    if pos_x and pos_y and pos_z then
                        local distance = utils.distance_to_mob(mob_index)
                        log(string.format('  Distance: %.1f yalms', distance))
                        
                        -- Check if would be detected
                        local would_detect = (hpp == nil or hpp > 0) and 
                                           distance <= config.max_distance and 
                                           is_nm
                        log(string.format('  Would Detect: %s', would_detect and 'YES' or 'NO'))
                        
                        -- Show why not if it wouldn't detect
                        if not would_detect and is_nm then
                            if not valid_target then log('    Reason: Not a valid target') end
                            if hpp and hpp <= 0 then log('    Reason: HPP is 0 (dead)') end
                            if distance > config.max_distance then 
                                log(string.format('    Reason: Too far (%.1f > %.1f)', distance, config.max_distance)) 
                            end
                        end
                        
                        -- Force show notification for testing
                        if is_nm then
                            local nm_details = nm_database.get_details(name)
                            
                            local nm_data = {
                                name = name,
                                level = nm_details and nm_details.level or '??',
                                family = nm_details and nm_details.family or 'Test',
                                zone = nm_details and nm_details.zone or 'Test Zone',
                                distance = distance,
                                hpp = hpp or 100,
                                mob_id = id
                            }
                            
                            log('Showing test notification...')
                            if config.show_ui then
                                ui.show_nm(nm_data)
                            end
                        end
                    else
                        log('  No position data available - cannot calculate distance')
                    end
                end
            else
                log(string.format('Mob index %d not found', mob_index))
                log('Use //nmscan mobs to see all current mob indexes')
            end
        else
            log('Usage: //nmscan test <mob_index>')
            log('Use //nmscan mobs to see available indexes')
        end
    else
        log(string.format('Unknown command: %s (use //nmscan help)', command))
    end
end)