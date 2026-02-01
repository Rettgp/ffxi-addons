--[[
    UI Module
    Handles the text-based interface for quest tracking
]]--

local texts = require('texts')
local state = require('state')
local quest_db = require('quest_database')

local ui = {}

-- UI State
ui.is_open = true
ui.collapsed_quests = {}  -- Track which quests are collapsed
ui.text_obj = nil

-- Text display settings
local defaults = {
    pos = {x = 100, y = 100},
    bg = {alpha = 200, red = 0, green = 0, blue = 0, visible = false},
    flags = {right = false, bottom = false, bold = false, italic = false, draggable = true},
    padding = 8,
    text = {
        size = 12,
        font = 'Consolas',
        alpha = 255,
        red = 255,
        green = 255,
        blue = 255,
        stroke = {width = 0.5, alpha = 255, red = 0, green = 0, blue = 0}
    }
}

-- Track step line positions for click detection
ui.step_lines = {}  -- Map of line_number -> {quest_id, step_number}

-- Initialize UI
function ui.init()
    ui.text_obj = texts.new('${content}', defaults)
    ui.text_obj.content = 'Questie - Loading...'
    ui.text_obj:show()
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
    table.insert(content, '\\cs(100,150,255)═══ Questie Tracker ═══\\cr')
    table.insert(content, '\\cs(150,150,150)Commands: //questie help\\cr')
    table.insert(content, '')
    
    -- Collect all missions and quests
    local missions = {}
    local quests = {}
    
    -- Collect from game data
    if ffxi then
        -- Nation missions - Use completed count to determine current mission
        if ffxi.missions and ffxi.missions.nations and ffxi.nation ~= nil 
           and ffxi.missions.nations[ffxi.nation] then
            local nation_names = {[0] = 'sandoria', [1] = 'bastok', [2] = 'windurst'}
            local nation_display = {[0] = 'San d\'Oria', [1] = 'Bastok', [2] = 'Windurst'}
            local nation = nation_names[ffxi.nation]
            local nation_name = nation_display[ffxi.nation] or 'Unknown'
            
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
                display_name = nation_name .. ' ' .. quest.name
            else
                display_name = nation_name .. ' Mission (Index: ' .. current_mission_index .. ')'
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
                   and name ~= 'nation' and name ~= 'nations' then
                    local mission_value = mission_data.current
                    
                    -- Look up quest by game ID and expansion name
                    local quest = quest_db.get_by_game_id(mission_value, name)
                    
                    local display_name
                    if quest then
                        display_name = name .. ' ' .. quest.name
                    else
                        display_name = name .. ' Mission (ID: ' .. mission_value .. ')'
                    end
                    
                    table.insert(missions, {
                        id = quest and quest.id or ('unknown_' .. name .. '_' .. mission_value),
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
    
    -- Display Missions section
    if #missions > 0 then
        table.insert(content, '\\cs(255,200,100)Missions:\\cr')
        for _, mission_data in ipairs(missions) do
            if mission_data.quest then
                ui.render_quest_item(content, mission_data.quest, mission_data.display_name, mission_data.from_game)
            else
                table.insert(content, string.format('   \\cs(150,200,255)[M]\\cr %s', mission_data.display_name))
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
                table.insert(content, string.format('   \\cs(150,200,255)[Q]\\cr %s', quest_data.display_name))
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
    
    table.insert(content, '\\cs(100,150,255)═══════════════════════════════\\cr')
    
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
    
    -- Check if collapsed (only for tracked quests)
    local is_collapsed = ui.collapsed_quests[quest_id]
    
    -- Quest header
    if from_game or not is_collapsed then
        table.insert(content, string.format('   \\cs(150,200,255)[%s]\\cr %s \\cs(150,150,150)[%d/%d]\\cr',
            quest.type == 'mission' and 'M' or 'Q', display_name, completed_count, total_steps))
    else
        -- Collapsed tracked quest - show with collapse icon
        local collapse_icon = '[+]'
        table.insert(content, string.format('   \\cs(255,200,100)%s\\cr \\cs(150,200,255)[%s]\\cr %s \\cs(150,150,150)[%d/%d]\\cr',
            collapse_icon, quest.type == 'mission' and 'M' or 'Q', display_name, completed_count, total_steps))
    end
    
    -- Show steps if from game or not collapsed
    if from_game or not is_collapsed then
        if total_steps > 0 then
            -- Find current step (first uncompleted step)
            local current_step = nil
            for i = 1, total_steps do
                if not state.is_step_completed(quest_id, i) then
                    current_step = i
                    break
                end
            end
            
            -- Show current step with clickable checkbox
            if current_step then
                local line_num = #content + 1
                ui.step_lines[line_num] = {quest_id = quest_id, step_num = current_step}
                table.insert(content, string.format('      \\cs(200,200,200)[ ]\\cr \\cs(255,255,100)%s\\cr', quest.steps[current_step]))
            end
            
            -- Show completed steps (non-clickable)
            for i, step in ipairs(quest.steps) do
                if state.is_step_completed(quest_id, i) then
                    table.insert(content, string.format('      \\cs(100,255,100)✓ %s\\cr', step))
                end
            end
        end
    end
end

-- Render function (called each frame)
function ui.render()
    -- Update happens on demand, not every frame
end

-- Handle mouse click events
function ui.handle_mouse_event(event_type, x, y, delta, blocked)
    if event_type ~= 1 then  -- type 1 = left click
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
    print(pos_x, pos_y)
    print(x, y)
    
    if not pos_x or not pos_y then
        return false
    end
    
    local settings = ui.text_obj:settings()
    local line_height = settings.text.size + 4  -- Font size + some spacing
    
    -- Check if click is within the text box
    if x < pos_x or x > pos_x + 400 then  -- Approximate width
        return false
    end
    
    -- Calculate which line was clicked
    local relative_y = y - pos_y
    if relative_y < 0 then
        return false
    end
    
    local line_clicked = math.floor(relative_y / line_height) + 1
    
    -- Check if this line has a clickable step
    local step_data = ui.step_lines[line_clicked]
    if step_data then
        -- Mark step as completed
        state.complete_step(step_data.quest_id, step_data.step_num)
        log.info('Step ' .. step_data.step_num .. ' marked complete!')
        
        -- Update UI
        ui.update()
        return true  -- Block the click from propagating
    end
    
    return false
end

return ui
