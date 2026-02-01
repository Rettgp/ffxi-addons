--[[
    Logging Module
    Handles console output for the addon
]]--

local log = {}

-- Info message (default) - prefix in light blue, message in white
function log.info(message)
    local prefix = string.char(31, 207) .. '[Questie]' .. string.char(31, 1)
    windower.add_to_chat(1, prefix .. ' ' .. message)
end

-- Error message - prefix in red, message in white  
function log.error(message)
    local prefix = string.char(31, 167) .. '[Questie]' .. string.char(31, 1)
    windower.add_to_chat(1, prefix .. ' Error: ' .. message)
end

-- Success message - prefix in green, message in white
function log.success(message)
    local prefix = string.char(31, 158) .. '[Questie]' .. string.char(31, 1)
    windower.add_to_chat(1, prefix .. ' ' .. message)
end

-- Warning message - prefix in yellow, message in white
function log.warning(message)
    local prefix = string.char(31, 159) .. '[Questie]' .. string.char(31, 1)
    windower.add_to_chat(1, prefix .. ' ' .. message)
end

return log
