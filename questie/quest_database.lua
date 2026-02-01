--[[
    Quest Database Module
    Handles loading and accessing quest data
]]--

local log = require('log')

local quest_db = {}

quest_db.quests = {}
quest_db.quest_map = {}  -- Map of quest_id -> quest for fast lookup

-- Load quest database from JSON
function quest_db.load()
    local file_path = windower.addon_path .. 'quest_data.lua'
    local loader = loadfile(file_path)
    
    if not loader then
        log.error('Could not load quest_data.lua')
        return false
    end
    
    local success, data = pcall(loader)
    
    if not success then
        log.error('Failed to load quest_data.lua')
        log.error('Error details: ' .. tostring(data))
        return false
    end
    
    if not data or not data.quests then
        log.error('Quest data loaded but missing quests')
        return false
    end
    
    quest_db.quests = data.quests
    
    -- Build quest map for fast lookup
    quest_db.quest_map = {}
    for _, quest in ipairs(quest_db.quests) do
        quest_db.quest_map[quest.id] = quest
    end
    
    log.success(string.format('Loaded %d quests from database.', #quest_db.quests))
    return true
end

-- Reload database
function quest_db.reload()
    return quest_db.load()
end

-- Get a specific quest by ID
function quest_db.get_quest(quest_id)
    return quest_db.quest_map[quest_id]
end

-- Get quest by game ID and nation/expansion
function quest_db.get_by_game_id(game_id, nation_or_expansion)
    for _, quest in ipairs(quest_db.quests) do
        if quest.game_id == game_id then
            -- For nation missions
            if nation_or_expansion and quest.nation then
                if quest.nation == nation_or_expansion then
                    return quest
                end
            -- For expansion missions (match by location/expansion name)
            elseif nation_or_expansion and quest.location then
                if quest.location:lower():gsub(' ', '_') == nation_or_expansion:lower():gsub(' ', '_') then
                    return quest
                end
            -- No filter specified, return first match
            elseif not nation_or_expansion then
                return quest
            end
        end
    end
    return nil
end

-- Get quest by mission index (for nation missions using completed count)
function quest_db.get_by_mission_index(mission_index, nation)
    for _, quest in ipairs(quest_db.quests) do
        if quest.mission_index == mission_index and quest.nation == nation then
            return quest
        end
    end
    return nil
end

-- Get all quests
function quest_db.get_all_quests()
    return quest_db.quests
end

-- Search quests by name
function quest_db.search(search_term)
    local results = {}
    local term_lower = search_term:lower()
    
    for _, quest in ipairs(quest_db.quests) do
        if quest.name:lower():find(term_lower, 1, true) then
            table.insert(results, quest)
        end
    end
    
    return results
end

-- Get quests by location
function quest_db.get_by_location(location)
    local results = {}
    local location_lower = location:lower()
    
    for _, quest in ipairs(quest_db.quests) do
        if quest.location:lower() == location_lower then
            table.insert(results, quest)
        end
    end
    
    return results
end

-- Get quests by type (quest or mission)
function quest_db.get_by_type(quest_type)
    local results = {}
    local type_lower = quest_type:lower()
    
    for _, quest in ipairs(quest_db.quests) do
        if quest.type:lower() == type_lower then
            table.insert(results, quest)
        end
    end
    
    return results
end

return quest_db
