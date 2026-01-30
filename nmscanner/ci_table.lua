ci_table_meta = {
    __newindex = function(tab, key, val)
            rawset(tab, case_insensitive_filter(key), val)
        end,

    __index = function(tab, key)
        return rawget(tab, case_insensitive_filter(key))
    end
    }

-----------------------------------------------------------------------------------
--Name: case_insensitive_filter(val)
--Args:
---- val (key): potential key to be modified
-----------------------------------------------------------------------------------
--Returns:
---- Filtered key
-----------------------------------------------------------------------------------
function case_insensitive_filter(val)
    if type(val) == 'string' then
        val = string.lower(val)
    end
    return val
end


-----------------------------------------------------------------------------------
--Name: case_insensitive_table()
--Args:
---- None
-----------------------------------------------------------------------------------
--Returns:
---- Table with case-insensitive keys
-----------------------------------------------------------------------------------
function case_insensitive_table()
    return setmetatable({}, ci_table_meta)
end