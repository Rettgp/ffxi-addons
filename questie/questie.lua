--[[
    A comprehensive quest and mission tracking addon that helps you
    keep track of your progress through FFXI's many quests and missions.
]] --

_addon.name = 'questie'
_addon.author = 'Rett'
_addon.version = '1.09'
_addon.commands = { 'questie', 'quest' }

-- Required libraries
require('luau')
require('ffxi')
config = require('config')
local log = require('log')
local state = require('state')
local ui = require('ui')
local quest_db = require('quest_database')

-- Default settings
local defaults = {
    pos = { x = 100, y = 100 },
    bg = { alpha = 200, red = 0, green = 0, blue = 0, visible = false },
    flags = { right = false, bottom = false, bold = true, italic = false, draggable = true },
    padding = 8,
    text = {
        size = 12,
        font = 'Consolas',
        alpha = 255,
        red = 255,
        green = 255,
        blue = 255,
        stroke = { width = 0.5, alpha = 255, red = 0, green = 0, blue = 0 }
    }
}

local settings = config.load(defaults)

-- Validate position to prevent crazy values
if settings.pos.x < 0 or settings.pos.x > 5000 then
    settings.pos.x = defaults.pos.x
end
if settings.pos.y < 0 or settings.pos.y > 5000 then
    settings.pos.y = defaults.pos.y
end

config.save(settings)

-- Initialize addon
windower.register_event('load', function()
    -- Load quest database
    quest_db.load()

    -- Load character state
    state.load()

    -- Initialize UI with settings
    ui.init(settings)
end)



-- Save state on logout/unload
windower.register_event('logout', 'unload', function()
    state.save()
    settings:save()
end)

-- Register UI update callback for when quest/mission data changes
if not ffxi.quest_update_callbacks then
    ffxi.quest_update_callbacks = {}
end
table.insert(ffxi.quest_update_callbacks, function()
    ui.update()
end)

-- Command handler
windower.register_event('addon command', function(command, ...)
    local args = { ... }
    command = command and command:lower() or 'help'

    if command == 'help' then
        log.info('=== Questie Commands ===')
        log.info('//questie or //quest - Toggle UI window')
        log.info('//questie show - Show UI window')
        log.info('//questie hide - Hide UI window')
        log.info('//questie add <quest_id> - Add a quest by ID')
        log.info('//questie remove <quest_id> - Remove a quest by ID')
        log.info('//questie list - List all active quests')
        log.info('//questie search <name> - Search for quests by name')
        log.info('//questie expand <quest_id> - Expand a quest')
        log.info('//questie collapse <quest_id> - Collapse a quest')
        log.info('//questie step <quest_id> <step_num> - Toggle step completion')
        log.info('//questie scan - Scan and match game quests with database')
        log.info('//questie reload - Reload quest database')
        log.info('//questie save - Manually save state')
    elseif command == 'show' then
        ui.show()
        log.info('Window shown.')
    elseif command == 'hide' then
        ui.hide()
        log.info('Window hidden.')
    elseif command == 'toggle' or command == '' then
        ui.toggle()
        local status = ui.is_open and 'shown' or 'hidden'
        log.info('Window ' .. status .. '.')
    elseif command == 'add' then
        if #args == 0 then
            log.error('Usage: //questie add <quest_id>')
            return
        end

        local quest_id = args[1]
        local quest = quest_db.get_quest(quest_id)

        if not quest then
            log.error('Quest not found: ' .. quest_id)
            return
        end

        if state.add_quest(quest_id) then
            log.success('Added quest: ' .. quest.name)
            ui.update()
        else
            log.warning('Quest already active: ' .. quest.name)
        end
    elseif command == 'remove' then
        if #args == 0 then
            log.error('Usage: //questie remove <quest_id>')
            return
        end

        local quest_id = args[1]
        local quest = quest_db.get_quest(quest_id)

        if state.remove_quest(quest_id) then
            local name = quest and quest.name or quest_id
            log.success('Removed quest: ' .. name)
            ui.update()
        else
            log.error('Quest not found in active list.')
        end
    elseif command == 'list' then
        local active_quests = state.get_active_quests()

        if #active_quests == 0 then
            log.info('No active quests.')
            return
        end

        log.info('=== Active Quests ===')
        for _, quest_id in ipairs(active_quests) do
            local quest = quest_db.get_quest(quest_id)
            if quest then
                local progress = state.get_progress(quest_id)
                local completed = #progress.completed_steps
                local total = #quest.steps
                log.info(string.format('  [%d/%d] %s (%s)',
                    completed, total, quest.name, quest_id))
            end
        end
    elseif command == 'search' then
        if #args == 0 then
            log.error('Usage: //questie search <name>')
            return
        end

        local search_term = table.concat(args, ' ')
        local results = quest_db.search(search_term)

        if #results == 0 then
            log.info('No quests found matching: ' .. search_term)
            return
        end

        log.info('=== Search Results ===')
        for _, quest in ipairs(results) do
            local status = state.is_quest_active(quest.id) and '[ACTIVE]' or ''
            log.info(string.format('  %s %s - %s (%s)',
                status, quest.name, quest.location, quest.id))
        end
    elseif command == 'reload' then
        quest_db.reload()
        ui.update()
        log.success('Quest database reloaded.')
    elseif command == 'expand' then
        if #args == 0 then
            log.error('Usage: //questie expand <quest_id>')
            return
        end

        local quest_id = args[1]
        ui.collapsed_quests[quest_id] = false
        ui.update()
        log.info('Expanded quest: ' .. quest_id)
    elseif command == 'collapse' then
        if #args == 0 then
            log.error('Usage: //questie collapse <quest_id>')
            return
        end

        local quest_id = args[1]
        ui.collapsed_quests[quest_id] = true
        ui.update()
        log.info('Collapsed quest: ' .. quest_id)
    elseif command == 'step' then
        if #args < 2 then
            log.error('Usage: //questie step <quest_id> <step_number>')
            return
        end

        local quest_id = args[1]
        local step_num = tonumber(args[2])

        if not step_num then
            log.error('Error: Step number must be a number.')
            return
        end

        local quest = quest_db.get_quest(quest_id)
        if not quest then
            log.error('Quest not found: ' .. quest_id)
            return
        end

        if step_num < 1 or step_num > #quest.steps then
            log.error(string.format('Error: Step must be between 1 and %d', #quest.steps))
            return
        end

        state.toggle_step(quest_id, step_num)
        ui.update()

        local is_completed = state.is_step_completed(quest_id, step_num)
        local status = is_completed and 'completed' or 'uncompleted'
        log.info(string.format('Marked step %d as %s', step_num, status))
    elseif command == 'save' then
        if state.save() then
            log.success('State saved successfully.')
        end
    elseif command == 'scan' then
        -- Scan database and show all available quests
        log.info('=== Available Quests in Database ===')

        local all_quests = quest_db.get_all_quests()
        local active_quests = state.get_active_quests()

        -- Create a set of active quest IDs for quick lookup
        local active_set = {}
        for _, qid in ipairs(active_quests) do
            active_set[qid] = true
        end

        -- Group quests by location
        local by_location = {}
        for _, quest in ipairs(all_quests) do
            if not by_location[quest.location] then
                by_location[quest.location] = {}
            end
            table.insert(by_location[quest.location], quest)
        end

        -- Display quests grouped by location
        for location, quests in pairs(by_location) do
            log.info('')
            log.warning(location .. ':')
            for _, quest in ipairs(quests) do
                local status = active_set[quest.id] and '\\cs(100,255,100)[TRACKING]\\cr' or ''
                local quest_type = quest.type == 'mission' and '[M]' or '[Q]'
                log.info(string.format('  %s %s %s - ID: %s',
                    quest_type, quest.name, status, quest.id))
            end
        end

        log.info('')
        log.info(string.format('Total: %d quests/missions in database', #all_quests))
        log.info('Use //questie add <quest_id> to track a quest')
    else
        log.error('Unknown command. Use //questie help for available commands.')
    end
end)
