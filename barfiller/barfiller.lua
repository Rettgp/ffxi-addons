_addon.name = 'BarFiller'
_addon.author = 'Rett'
_addon.version = '1.0.0'
_addon.commands = {'bf','barfiller'}
_addon.language = 'english'

-- Windower Libs
config = require('config')
file = require('files')
packets = require('packets')
texts = require('texts')
images = require('images')

-- BarFiller Libs
require('statics')

settings = config.load(defaults)
config.save(settings)

container          = images.new(settings.Images.Container)
background_image   = images.new(settings.Images.Background)
foreground_image   = images.new(settings.Images.Foreground)
rested_bonus_image = images.new(settings.Images.RestedBonus)

exp_text = texts.new(settings.Texts.Exp)
job_text = texts.new(settings.Texts.Job)

debug = false
ready = false
chunk_update = false

windower.register_event('load',function()
    if windower.ffxi.get_info().logged_in then
        initialize()
    end
end)

windower.register_event('login',function()
    initialize()
end)

windower.register_event('logout',function()
    hide()
end)

windower.register_event('addon command',function(command, ...)
    local commands = {...}
    local first_cmd = (command or 'help'):lower()
    if approved_commands[first_cmd] and #commands >= approved_commands[first_cmd].n then
        if first_cmd == 'clear' or first_cmd == 'c' then
            initialize()
        elseif first_cmd == 'visible' or first_cmd == 'v' then
            if ready then hide() else show() end
        elseif first_cmd == 'reload' or first_cmd == 'r' then
            windower.add_to_chat(8,'BarFiller successfully reloaded.')
            windower.send_command('lua r barfiller;')
        elseif first_cmd == 'unload' or first_cmd == 'u' then
            windower.send_command('lua u barfiller;')
            windower.add_to_chat(8,'BarFiller successfully unloaded.')
        elseif first_cmd == 'help' or first_cmd == 'h' then
            display_help()
        end
    else
        display_help()
    end
end)

windower.register_event('incoming chunk',function(id,org,modi,is_injected,is_blocked)
    if is_injected then return end
    if ready then
        -- Thanks to smd111 for Packet parsing
        local packet_table = packets.parse('incoming', org)
        if id == 0x2D then
            exp_msg(packet_table['Param 1'],packet_table['Message'])
        elseif id == 0x61 then
            xp.current = packet_table['Current EXP']
            xp.total = packet_table['Required EXP']
            xp.tnl = xp.total - xp.current
            chunk_update = true
        end
    end
end)

windower.register_event('prerender',function()
    -- Update all element positions when container is dragged
    if container then
        local container_x = container:pos_x()
        local container_y = container:pos_y()
        
        if container_x ~= settings.Images.Container.Pos.X or container_y ~= settings.Images.Container.Pos.Y then
            update_element_positions()
        end
    end
    
    if ready and chunk_update then
        local old_width = foreground_image:width()
        local new_width = calc_new_width()

        -- Thanks to Iryoku for the logic on smooth animations
        if new_width ~= nil and new_width > 0 then
            if old_width < new_width then
                local last_update = 0
                local x = old_width + math.ceil(((new_width - old_width) * 0.1))
                foreground_image:size(x, settings.Images.Foreground.Size.Height)
                if debug then print(old_width, x, new_width) end

                local now = os.time()
                if now - last_update > 0.5 then
                    update_strings()
                    last_update = now
                end
            elseif old_width >= new_width then
                foreground_image:size(new_width, settings.Images.Foreground.Size.Height)
                chunk_update = false
                if debug then print(chunk_update) end
            end
        end
    end
end)

windower.register_event('level up', function(level)
    update_strings()
end)

windower.register_event('level down', function(level)
    update_strings()
end)

windower.register_event('zone change', function(new_id,old_id)
    mog_house()
end)
