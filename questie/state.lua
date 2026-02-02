--[[
    State Management Module
    Handles saving/loading quest progress and active quests
]]--

local log = require('log')

local state = {}

state.data = {
    active_quests = {},  -- List of quest IDs that are currently active
    quest_progress = {}  -- Map of quest_id -> {completed_steps = {}, current_step = 1}
}

-- Get the save file path
function state.get_save_path()
    local character_name = windower.ffxi.get_player().name
    return windower.addon_path .. 'data/' .. character_name .. '_state.lua'
end

-- Serialize table to Lua code
local function serialize_table(tbl, indent)
    indent = indent or ''
    local lines = {}
    table.insert(lines, '{')
    
    for k, v in pairs(tbl) do
        local key_str
        if type(k) == 'string' then
            key_str = string.format('[%q]', k)
        else
            key_str = '[' .. tostring(k) .. ']'
        end
        
        local value_str
        if type(v) == 'table' then
            value_str = serialize_table(v, indent .. '  ')
        elseif type(v) == 'string' then
            value_str = string.format('%q', v)
        else
            value_str = tostring(v)
        end
        
        table.insert(lines, string.format('%s  %s = %s,', indent, key_str, value_str))
    end
    
    table.insert(lines, indent .. '}')
    return table.concat(lines, '\n')
end

-- Load state from file
function state.load()
    local file_path = state.get_save_path()
    local loader = loadfile(file_path)
    
    if loader then
        local success, loaded_data = pcall(loader)
        
        if success and loaded_data then
            state.data = loaded_data
            log.info('State loaded for character.')
        else
            log.error('Failed to parse saved state.')
        end
    else
        log.info('No saved state found, starting fresh.')
    end
end

-- Save state to file
function state.save()
    local file_path = state.get_save_path()
    
    -- Ensure data directory exists
    local data_dir = windower.addon_path .. 'data/'
    windower.create_dir(data_dir)
    
    local file = io.open(file_path, 'w')
    if file then
        file:write('return ')
        file:write(serialize_table(state.data))
        file:close()
        return true
    else
        log.error('Could not save state.')
        return false
    end
end

-- Add a quest to active list
function state.add_quest(quest_id)
    if not state.is_quest_active(quest_id) then
        table.insert(state.data.active_quests, quest_id)
        -- Only create new progress if it doesn't already exist
        if not state.data.quest_progress[quest_id] then
            state.data.quest_progress[quest_id] = {
                completed_steps = {},
                current_step = 1
            }
        end
        state.save()
        return true
    end
    return false
end

-- Remove a quest from active list
function state.remove_quest(quest_id)
    for i, qid in ipairs(state.data.active_quests) do
        if qid == quest_id then
            table.remove(state.data.active_quests, i)
            state.data.quest_progress[quest_id] = nil
            state.save()
            return true
        end
    end
    return false
end

-- Check if quest is active
function state.is_quest_active(quest_id)
    for _, qid in ipairs(state.data.active_quests) do
        if qid == quest_id then
            return true
        end
    end
    return false
end

-- Toggle step completion
function state.toggle_step(quest_id, step_index)
    if not state.data.quest_progress[quest_id] then
        return false
    end
    
    local progress = state.data.quest_progress[quest_id]
    local completed = progress.completed_steps
    
    -- Check if step is already completed
    local is_completed = false
    local index_to_remove = nil
    for i, step_idx in ipairs(completed) do
        if step_idx == step_index then
            is_completed = true
            index_to_remove = i
            break
        end
    end
    
    if is_completed then
        -- Uncomplete the step
        table.remove(completed, index_to_remove)
    else
        -- Complete the step
        table.insert(completed, step_index)
        
        -- Update current step if needed
        if step_index >= progress.current_step then
            progress.current_step = step_index + 1
        end
    end
    
    state.save()
    return true
end

-- Complete a step (only mark as complete, don't toggle)
function state.complete_step(quest_id, step_index)
    if not state.data.quest_progress[quest_id] then
        return false
    end
    
    local progress = state.data.quest_progress[quest_id]
    local completed = progress.completed_steps
    
    -- Check if step is already completed
    for _, step_idx in ipairs(completed) do
        if step_idx == step_index then
            return true  -- Already completed
        end
    end
    
    -- Complete the step
    table.insert(completed, step_index)
    
    -- Update current step
    if step_index >= progress.current_step then
        progress.current_step = step_index + 1
    end
    
    state.save()
    return true
end

-- Uncomplete a step (remove completion)
function state.uncomplete_step(quest_id, step_index)
    if not state.data.quest_progress[quest_id] then
        return false
    end
    
    local progress = state.data.quest_progress[quest_id]
    local completed = progress.completed_steps
    
    -- Find and remove the step
    for i, step_idx in ipairs(completed) do
        if step_idx == step_index then
            table.remove(completed, i)
            state.save()
            return true
        end
    end
    
    return false  -- Step wasn't completed
end

-- Check if a step is completed
function state.is_step_completed(quest_id, step_index)
    if not state.data.quest_progress[quest_id] then
        return false
    end
    
    for _, idx in ipairs(state.data.quest_progress[quest_id].completed_steps) do
        if idx == step_index then
            return true
        end
    end
    return false
end

-- Get quest progress
function state.get_progress(quest_id)
    return state.data.quest_progress[quest_id]
end

-- Get all active quests
function state.get_active_quests()
    return state.data.active_quests
end

return state
