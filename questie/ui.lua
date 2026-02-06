--[[
    UI Module
    Handles the text-based interface for quest tracking
]] --

local texts = require('texts')
local state = require('state')
local quest_db = require('quest_database')
local log = require('log')

local ui = {}

-- UI State
ui.is_open = true
ui.collapsed_quests = {} -- Track which quests are collapsed
ui.text_obj = nil
ui.tooltip_obj = nil
ui.line_height = 19
ui.settings = nil -- Will be set by init()

local tooltip_defaults = {
    pos = { x = 0, y = 0 },
    bg = { alpha = 230, red = 20, green = 20, blue = 20, visible = true },
    flags = { right = false, bottom = false, bold = false, italic = false, draggable = false },
    padding = 4,
    text = {
        size = 11,
        font = 'Consolas',
        alpha = 255,
        red = 255,
        green = 255,
        blue = 100,
        stroke = { width = 0.5, alpha = 255, red = 0, green = 0, blue = 0 }
    }
}

-- Track step line positions for click detection
ui.step_lines = {}    -- Map of line_number -> {quest_id, step_number}
ui.quest_headers = {} -- Map of line_number -> quest_id

-- Constants
local MAX_LINE_LENGTH = 50 -- Characters before wrapping

-- Helper function to wrap text at a maximum character width
local function wrap_text(text, max_width, indent)
    indent = indent or ''
    local lines = {}
    local current_line = ''

    for word in text:gmatch('%S+') do
        local test_line = current_line == '' and word or current_line .. ' ' .. word
        if #test_line > max_width then
            if current_line ~= '' then
                table.insert(lines, current_line)
                current_line = word
            else
                -- Single word longer than max_width
                table.insert(lines, word)
                current_line = ''
            end
        else
            current_line = test_line
        end
    end

    if current_line ~= '' then
        table.insert(lines, current_line)
    end

    -- Add indent to continuation lines
    for i = 2, #lines do
        lines[i] = indent .. lines[i]
    end

    return lines
end

-- Initialize UI
function ui.init(settings)
    ui.settings = settings

    -- Create a plain table copy of settings for texts.new()
    -- (Config objects have metatables that may interfere with the texts library)
    local text_settings = {
        pos = settings.pos,
        bg = settings.bg,
        flags = settings.flags,
        padding = settings.padding,
        text = settings.text
    }

    ui.text_obj = texts.new('${content}', text_settings)
    ui.text_obj.content = 'Questie - Loading...'
    ui.text_obj:show()

    ui.line_height = ui.settings.text.size + 7

    ui.tooltip_obj = texts.new('${content}', tooltip_defaults)
    ui.tooltip_obj:hide()

    ui.update()

    -- Register click handler
    windower.register_event('mouse', ui.handle_mouse_event)
end

-- Toggle window visibility
function ui.toggle()
    ui.is_open = not ui.is_open
    if ui.is_open then
        ui.text_obj:show()
        ui.update()
    else
        ui.text_obj:hide()
    end
end

-- Show window
function ui.show()
    ui.is_open = true
    ui.text_obj:show()
    ui.update()
end

-- Hide window
function ui.hide()
    ui.is_open = false
    ui.text_obj:hide()
end

-- Update the display
function ui.update()
    if not ui.is_open or not ui.text_obj then
        return
    end

    local content = {}
    table.insert(content, '\\cs(100,150,255)═══════════════ Questie Tracker ═══════════════\\cr')

    -- Collect all missions and quests
    local missions = {}
    local quests = {}

    -- Collect from game data
    if ffxi then
        -- Nation missions - Use completed count to determine current mission
        if ffxi.missions and ffxi.missions.nations and ffxi.nation ~= nil
            and ffxi.missions.nations[ffxi.nation] then
            local nation_names = { [0] = 'sandoria', [1] = 'bastok', [2] = 'windurst' }
            local nation = nation_names[ffxi.nation]

            -- Count completed missions for this nation
            local completed = ffxi.missions.nations[ffxi.nation].completed or {}
            local completed_count = 0
            for _ in pairs(completed) do
                completed_count = completed_count + 1
            end

            -- Current mission index = number of completed missions
            local current_mission_index = completed_count

            -- Look up quest by mission index
            local quest = quest_db.get_by_mission_index(current_mission_index, nation)

            local display_name
            if quest then
                display_name = quest.name
            else
                display_name = ' Mission (Index: ' .. current_mission_index .. ')'
            end

            table.insert(missions, {
                id = quest and quest.id or ('unknown_' .. nation .. '_' .. current_mission_index),
                quest = quest,
                display_name = display_name,
                from_game = true,
                completed_missions = completed
            })
        end

        -- Expansion missions
        if ffxi.missions then
            for name, mission_data in pairs(ffxi.missions) do
                if type(mission_data) == 'table' and mission_data.current and mission_data.current > 0
                    and mission_data.current ~= 999
                    and name ~= 'nation' and name ~= 'nations' and name ~= nil then
                    -- Normalize expansion name for lookup
                    local expansion_key = name:lower():gsub(' ', '_'):gsub("'", '')

                    local quest = nil

                    -- First, try looking up by game_id (for ROV and others that use internal IDs)
                    quest = quest_db.get_by_game_id(mission_data.current, expansion_key)

                    if not quest then
                        -- Check if expansion uses completed count (TOAU, WOTG)
                        local current_mission_index
                        if mission_data.completed then
                            -- Count completed missions for this expansion
                            local completed_count = 0
                            for _ in pairs(mission_data.completed) do
                                completed_count = completed_count + 1
                            end
                            current_mission_index = completed_count
                            -- Look up by mission index
                            quest = quest_db.get_by_mission_index(current_mission_index, expansion_key)
                        end
                    end

                    local display_name
                    if quest then
                        display_name = quest.name
                    else
                        display_name = name .. ' Mission (ID: ' .. mission_data.current .. ')'
                    end

                    table.insert(missions, {
                        id = quest and quest.id or ('unknown_' .. expansion_key .. '_' .. mission_data.current),
                        quest = quest,
                        display_name = display_name,
                        from_game = true
                    })
                end
            end
        end

        -- Active quests from game
        if ffxi.quests then
            for location, data in pairs(ffxi.quests) do
                if data.flagged and #data.flagged > 0 then
                    for _, quest_id in ipairs(data.flagged) do
                        local quest_data_id = string.format('%s_%d', location:lower():gsub(' ', '_'), quest_id)
                        local quest = quest_db.get_quest(quest_data_id)

                        table.insert(quests, {
                            id = quest_data_id,
                            quest = quest,
                            display_name = string.format('%s Quest %d', location, quest_id),
                            from_game = true
                        })
                    end
                end
            end
        end
    end

    -- Collect from tracked quests
    local active_quests = state.get_active_quests()

    -- Track which game missions/quests are currently active for cleanup
    local active_game_ids = {}
    for _, m in ipairs(missions) do
        if m.from_game and m.id then
            active_game_ids[m.id] = true
        end
    end
    for _, q in ipairs(quests) do
        if q.from_game and q.id then
            active_game_ids[q.id] = true
        end
    end

    -- Auto-remove completed game missions/quests from tracking
    -- ONLY if we actually have game mission data (to avoid wiping on reload before packet received)
    local has_mission_data = ffxi and ffxi.missions and ffxi.nation ~= nil
    if has_mission_data and #missions > 0 then
        for _, quest_id in ipairs(active_quests) do
            local quest = quest_db.get_quest(quest_id)
            if quest and (quest.game_id or quest.mission_index ~= nil) then
                -- This is a game mission/quest (has game_id or mission_index field)
                -- If it's not in the active game list, remove it
                if not active_game_ids[quest_id] then
                    state.remove_quest(quest_id)
                end
            end
        end

        -- Refresh active quests list after cleanup
        active_quests = state.get_active_quests()
    end

    for _, quest_id in ipairs(active_quests) do
        local quest = quest_db.get_quest(quest_id)
        if quest then
            -- Check if already added from game
            local already_added = false
            if quest.type == 'mission' then
                for _, m in ipairs(missions) do
                    if m.id == quest_id then
                        already_added = true
                        break
                    end
                end
                if not already_added then
                    table.insert(missions, {
                        id = quest_id,
                        quest = quest,
                        display_name = quest.name,
                        from_game = false
                    })
                end
            else
                for _, q in ipairs(quests) do
                    if q.id == quest_id then
                        already_added = true
                        break
                    end
                end
                if not already_added then
                    table.insert(quests, {
                        id = quest_id,
                        quest = quest,
                        display_name = quest.name,
                        from_game = false
                    })
                end
            end
        end
    end

    -- Reset step line tracking
    ui.step_lines = {}
    ui.quest_headers = {}

    -- Display Missions section
    if #missions > 0 then
        table.insert(content, '\\cs(255,200,100)Missions:\\cr')
        for _, mission_data in ipairs(missions) do
            if mission_data.quest then
                ui.render_quest_item(content, mission_data.quest, mission_data.display_name, mission_data.from_game)
            else
                -- Unknown mission
                table.insert(content, string.format('   \\cs(255,50,50)%s\\cr', mission_data.display_name))
            end
        end
        table.insert(content, '')
    end

    -- Display Quests section
    if #quests > 0 then
        table.insert(content, '\\cs(255,200,100)Quests:\\cr')
        for _, quest_data in ipairs(quests) do
            if quest_data.quest then
                ui.render_quest_item(content, quest_data.quest, quest_data.display_name, quest_data.from_game)
            else
                table.insert(content, string.format('   \\cs(150,200,255)%s\\cr', quest_data.display_name))
            end
        end
        table.insert(content, '')
    end

    -- Show help if nothing active
    if #missions == 0 and #quests == 0 then
        table.insert(content, '\\cs(150,150,150)No active quests or missions.\\cr')
        table.insert(content, '\\cs(150,150,150)Use //questie add <quest_id>\\cr')
        table.insert(content, '')
    end

    table.insert(content, '\\cs(100,150,255)═══════════════════════════════════════════════\\cr')

    ui.text_obj.content = table.concat(content, '\n')
end

-- Render quest/mission item (both from game and tracked)
function ui.render_quest_item(content, quest, display_name, from_game)
    local quest_id = quest.id

    -- Ensure this quest has progress tracking
    if not state.is_quest_active(quest_id) then
        state.add_quest(quest_id)
    end

    local progress = state.get_progress(quest_id)
    if not progress then
        return
    end

    -- Calculate completion
    local total_steps = #quest.steps
    local completed_count = #progress.completed_steps

    -- Check if collapsed
    local is_collapsed = ui.collapsed_quests[quest_id]

    -- Quest header with collapse icon
    local collapse_icon = is_collapsed and '[+]' or '[-]'
    local header_prefix = string.format('   \\cs(255,200,100)%s\\cr ', collapse_icon)
    local header_suffix = string.format(' \\cs(150,150,150)[%d/%d]\\cr', completed_count, total_steps)

    -- Wrap quest name if too long
    local wrapped_lines = wrap_text(display_name, MAX_LINE_LENGTH - 10, '      ')
    table.insert(content, header_prefix .. wrapped_lines[1] .. header_suffix)
    for i = 2, #wrapped_lines do
        table.insert(content, wrapped_lines[i])
    end

    -- Track this line as a quest header (AFTER adding to content)
    local header_line = #content
    ui.quest_headers[header_line] = quest_id

    -- Show steps if not collapsed
    if not is_collapsed then
        if total_steps > 0 then
            -- Find current step (first uncompleted step)
            local current_step = nil
            for i = 1, total_steps do
                if not state.is_step_completed(quest_id, i) then
                    current_step = i
                    break
                end
            end

            -- Show next step preview (smaller font, non-clickable)
            if current_step and current_step < total_steps then
                local next_step = current_step + 1
                local wrapped_next = wrap_text(quest.steps[next_step], MAX_LINE_LENGTH - 12, '            ')
                table.insert(content, string.format('      \\cs(120,120,120)    Next: %s\\cr', wrapped_next[1]))
                for i = 2, #wrapped_next do
                    table.insert(content, string.format('      \\cs(120,120,120)%s\\cr', wrapped_next[i]))
                end
            end

            -- Show current step first (clickable)
            if current_step then
                local wrapped_current = wrap_text(quest.steps[current_step], MAX_LINE_LENGTH - 8, '         ')
                table.insert(content,
                    string.format('      \\cs(200,200,200)[ ]\\cr \\cs(255,255,100)%s\\cr', wrapped_current[1]))
                -- Track this line as clickable step (AFTER adding to content)
                local line_num = #content
                ui.step_lines[line_num] = { quest_id = quest_id, step_num = current_step }
                -- Add continuation lines (not clickable)
                for i = 2, #wrapped_current do
                    table.insert(content, string.format('      \\cs(255,255,100)%s\\cr', wrapped_current[i]))
                end
            end

            -- Show only the most recently completed step (also clickable for uncomplete)
            if current_step and current_step > 1 then
                local prev_step = current_step - 1
                local step = quest.steps[prev_step]
                local wrapped_completed = wrap_text(step, MAX_LINE_LENGTH - 8, '         ')
                table.insert(content, string.format('      \\cs(100,255,100)[X] %s\\cr', wrapped_completed[1]))
                -- Track this line as clickable step (AFTER adding to content)
                local line_num = #content
                ui.step_lines[line_num] = { quest_id = quest_id, step_num = prev_step }
                -- Add continuation lines (not clickable)
                for j = 2, #wrapped_completed do
                    table.insert(content, string.format('      \\cs(100,255,100)%s\\cr', wrapped_completed[j]))
                end
            end
        end
    end
end

-- Render function (called each frame)
function ui.render()
    -- Update happens on demand, not every frame
end

-- Update tooltip based on mouse position
function ui.update_tooltip(x, y)
    if not ui.text_obj or not ui.text_obj:visible() or not ui.tooltip_obj then
        return
    end

    -- Get text object position
    local pos_x = ui.text_obj:pos_x()
    local pos_y = ui.text_obj:pos_y()

    if not pos_x or not pos_y then
        ui.tooltip_obj:hide()
        return
    end

    local padding = ui.settings.padding or 0

    -- Check if mouse is within the text box
    if x < pos_x or x > pos_x + 400 or y < pos_y then
        ui.tooltip_obj:hide()
        return
    end

    -- Calculate which line is hovered
    local relative_y = y - pos_y - padding
    if relative_y < 0 then
        ui.tooltip_obj:hide()
        return
    end

    local line_hovered = math.floor(relative_y / ui.line_height) + 1

    -- Check if hovering over a quest header
    local quest_id = ui.quest_headers[line_hovered]
    if quest_id then
        local is_collapsed = ui.collapsed_quests[quest_id]
        local tooltip_text = is_collapsed and 'Click to Expand' or 'Click to Collapse'
        ui.tooltip_obj.content = tooltip_text
        ui.tooltip_obj:pos(x + 15, y)
        ui.tooltip_obj:show()
        return
    end

    -- Check if hovering over a step
    local step_data = ui.step_lines[line_hovered]
    if step_data then
        local is_completed = state.is_step_completed(step_data.quest_id, step_data.step_num)
        local tooltip_text
        if is_completed then
            tooltip_text = 'Left-click: Mark as Incomplete'
        else
            tooltip_text = 'Left-click: Mark as Complete'
        end
        ui.tooltip_obj.content = tooltip_text
        ui.tooltip_obj:pos(x + 15, y)
        ui.tooltip_obj:show()
        return
    end

    -- Not hovering over anything interactive
    ui.tooltip_obj:hide()
end

-- Handle mouse click events
function ui.handle_mouse_event(event_type, x, y, delta, blocked)
    -- type 0 = move, type 1 = left click, type 2 = right click
    if event_type == 0 then
        -- Mouse move - update tooltip
        ui.update_tooltip(x, y)
        return false
    end

    if event_type ~= 1 then
        return false
    end

    -- Ensure x and y are numbers
    if type(x) ~= 'number' or type(y) ~= 'number' then
        return false
    end

    -- Check if click is within text object bounds
    if not ui.text_obj or not ui.text_obj:visible() then
        return false
    end

    -- Get position - pos() returns {x, y} or a table with x/y properties
    local pos_data = ui.text_obj:pos()
    if not pos_data then
        return false
    end

    -- Handle both array and object-style position data
    local pos_x = ui.text_obj:pos_x()
    local pos_y = ui.text_obj:pos_y()

    if not pos_x or not pos_y then
        return false
    end

    local padding = ui.settings.padding or 0

    -- Check if click is within the text box
    if x < pos_x or x > pos_x + 400 then -- Approximate width
        return false
    end

    -- Calculate which line was clicked (account for padding)
    local relative_y = y - pos_y - padding
    if relative_y < 0 then
        return false
    end

    local line_clicked = math.floor(relative_y / ui.line_height) + 1

    -- Check if this line is a quest header (for collapse/expand)
    local quest_id = ui.quest_headers[line_clicked]
    if quest_id and event_type == 1 then -- Left click on header
        ui.collapsed_quests[quest_id] = not ui.collapsed_quests[quest_id]
        ui.update()
        return true
    end

    -- Check if this line has a clickable step
    local step_data = ui.step_lines[line_clicked]
    if step_data then
        if event_type == 1 then -- Left click = complete
            state.complete_step(step_data.quest_id, step_data.step_num)
            log.info('Step ' .. step_data.step_num .. ' marked complete!')
        elseif event_type == 2 then -- Right click = uncomplete
            state.uncomplete_step(step_data.quest_id, step_data.step_num)
            log.info('Step ' .. step_data.step_num .. ' marked incomplete!')
        end

        -- Update UI
        ui.update()
        return true -- Block the click from propagating
    end

    return false
end

return ui
