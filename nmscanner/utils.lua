utils = {}

function utils.party_leader()

    if ffxi.party:length() == 1 or ffxi.party:length() == 0 then return true end

    local self = ffxi.party[ffxi.player.id]
    if not self then
        return true
    end
    local alliance_leader = ffxi.party:with('alliance_leader', true)
    
    if (alliance_leader and self.alliance_leader) or (not alliance_leader and self.party_leader) then
        return true
    end
    
    return false

end

function utils.party_leader_id()
    for member in ffxi.party:it() do
        if member.party_leader then
            return member.id
        end
    end

    return false
end

function utils.party_leader_index()
    for member in ffxi.party:it() do
        if member.party_leader then
            return member.index
        end
    end

    return false
end

function utils.assign_party_leader(member_name)
    if utils.party_leader() then
        windower.send_command('input /pcmd leader %s':format(member_name))
    end
end

function utils.add_to_party(member_name)
    if utils.party_leader() then
        windower.send_command('input /pcmd add %s':format(member_name))
    end
end

function utils.leave_party()
    windower.send_command('input /pcmd leave')
end

function utils.join_party()
    windower.send_command('input /join')
end

function utils.count_attackers()
    local attackers = 0
    local disabled = 0
    local ts = os.clock()
    for i,v in pairs(ffxi.mob_array) do
        if v.attacking then
            if ts  - v.last_attack > 5 then
                disabled = disabled + 1
            else
                attackers = attackers + 1
            end
        end
    end
    return attackers, disabled
end

function utils.validate_interaction(index, distance)

    local mob = false
    local valid = false

    if not index then 
        return false
    elseif type(index) == "string" then
        local client_mob = windower.ffxi.get_mob_by_name(index)
        mob = client_mob and ffxi.mob_array[client_mob.index] or nil
    elseif type(index) == "number" then
        mob = ffxi.mob_array[index]
    end
    
    if mob and mob.valid_target then
        valid = true
        local max_distance = distance or 10
        if utils.distance_to_mob(mob.index) <= max_distance then
            return true, mob
        end
    end
    
    if valid then
        warning('Too far away from NPC: ', index, distance)
        return true,nil
    else
        warning("Unable to locate NPC.")
        return false,nil
    end

end

function utils.validate_closest_interaction(index, distance, max_index, blacklist)
    local mob = false
    local valid = false
    local poke_mob_name = false
    local attemped_mob_index = nil

    if not index then 
        return false
    elseif type(index) == "string" then
        poke_mob_name = index
        local client_mob = windower.ffxi.get_mob_by_name(index)
        mob = client_mob and ffxi.mob_array[client_mob.index] or nil
        attemped_mob_index = mob and mob.index or nil
    elseif type(index) == "number" then
        mob = ffxi.mob_array[index]
    end
    
    if mob and mob.valid_target and not blacklist:contains(mob.index) then
        local max_distance = distance or 10
        if utils.distance_to_mob(mob.index) <= max_distance then
            valid = true
            return true, mob
        end
    end

    if not valid and attemped_mob_index then
        attempted_mob_index = attemped_mob_index + 1
        for i=attemped_mob_index, max_index do
            local try_mob = ffxi.mob_array[i]
            if try_mob and try_mob.valid_target then
                local try_mob_name = windower.ffxi.get_mob_by_index(try_mob.index).name

                if try_mob_name == poke_mob_name and 
                    not blacklist:contains(try_mob.index) 
                then
                    local max_distance = distance or 10
                    if utils.distance_to_mob(try_mob.index) <= max_distance then
                        valid = true
                        return true, try_mob
                    end
                end
            end
        end
    end
    
    if valid then
        warning('Too far away from NPC: ', index, distance)
        return true,nil
    else
        return false,nil
    end

end

function utils.poke(index, distance)
    local spawned,mob = utils.validate_interaction(index, distance)
    if spawned and mob then
        local p = packets.new('outgoing', 0x1a, {
            ["Target"] = mob.id,
            ["Target Index"] = mob.index,
        })
        packets.inject(p)
        return true
    elseif tonumber(index) and not spawned then
        log("Attempting to spawn: ", index)
        utils.request_pop(index)
    end

    return false
end

function utils.poke_closest(index, distance, max_index, blacklist)
    local spawned,mob = utils.validate_closest_interaction(index, distance, max_index, blacklist or L{})
    if spawned and mob then
        local p = packets.new('outgoing', 0x1a, {
            ["Target"] = mob.id,
            ["Target Index"] = mob.index,
        })
        packets.inject(p)
        return true, mob.index
    elseif tonumber(index) and not spawned then
        log("Attempting to spawn: ", index)
        utils.request_pop(index)
    end

    return false
end

function utils.find_closest_mobs(mobs)
    local type_check = class(mobs)
    if type_check ~= "Set" then
        error("utils.find_closest_mobs requires a S{} of mobs")
        coordinator.stop()
        return
    end

    local target_npcs = npcs.FindAll(ffxi.zone, mobs)

    if not target_npcs then
        return nil
    end

    local closest_distance = math.huge
    local closest_mob = nil

    for npc in target_npcs:it() do
        if ffxi.mob_array[npc.index] and
            utils.distance_to_mob(npc.index) < closest_distance and
            utils.can_fight(npc.index)
        then
            closest_distance = utils.distance_to_mob(npc.index)
            closest_mob = npc
        end
    end

    return closest_mob
end

function utils.find_closest_npcs(mobs)
    local type_check = class(mobs)
    if type_check ~= "Set" then
        error("utils.find_closest_npcs requires a S{} of npcs")
        coordinator.stop()
        return
    end

    local target_npcs = npcs.FindAll(ffxi.zone, mobs)

    if not target_npcs then
        return nil
    end

    local closest_distance = math.huge
    local closest_mob = nil

    for npc in target_npcs:it() do
        while not ffxi.mob_array[npc.index] do
            notice("Requesting pop: %d":format(npc.index))
            utils.request_pop(npc.index);
            coroutine.sleep(5)
        end
        if ffxi.mob_array[npc.index] and
            utils.distance_to_mob(npc.index) < closest_distance
        then
            closest_distance = utils.distance_to_mob(npc.index)
            closest_mob = npc
        end
    end

    return closest_mob
end

function utils.trade(item,npc_index,max_count,all)
    
    if not item or not npc_index or not max_count then 
        return false,'args'
    end
    
    local npc = ffxi.mob_array[npc_index]
    
    if not npc and tonumber(npc_index) then
        log("Attempting to spawn: ", npc_index)
        utils.request_pop(npc_index)
        return false,'npc'
    end
    
    local trade_index = 1
    local trade_count = 0
    local remaining = max_count
    local trade = packets.new('outgoing', 0x36, {
            ['Target'] = npc.id,
            ['Target Index'] = npc.index,
        })
    
    for index = 1, ffxi.items.inventory.size do
        if ffxi.items.inventory[index] then
            if remaining > 0 and ffxi.items.inventory[index].id == item then
                local count = 0
                
                if ffxi.items.inventory[index].count >= remaining then
                    count = remaining
                else
                    count = ffxi.items.inventory[index].count
                end
                trade['Item Index %d':format(trade_index)] = index
                trade['Item Count %d':format(trade_index)] = count
                remaining = remaining - count
                trade_count = trade_count + count
                trade_index = trade_index + 1
            end
        end
    end
    
    if trade_count < max_count and not all then
        return false,'items'
    end
    
        
    trade['Number of Items'] = trade_index - 1 
    packets.inject(trade)
    return true
end

function utils.trade_many(npc_index, items, all)
    if type(npc_index) == 'string' then
        local mob = windower.ffxi.get_mob_by_name(npc_index)
        if mob then
            npc_index = mob.index
        else
            error("utils.trade_many: Could not find mob from name: %s":format(npc_index))
            return false, 'npc'
        end
    end

    local npc = ffxi.mob_array[npc_index]
    
    if not npc and tonumber(npc_index) then
        log("Attempting to spawn: ", npc_index)
        utils.request_pop(npc_index)
        return false,'npc'
    end

    local trade_index = 1
    local trade_count = 0
    local trade = packets.new('outgoing', 0x36, {
            ['Target'] = npc.id,
            ['Target Index'] = npc.index,
        })

    if table.containskey(items, 'gil') or table.containskey(items, 'Gil') then
        trade_index = 2
    end

    for k,v in pairs(items) do
        if k:lower() == "gil" then
            trade['Item Index %d':format(1)] = 0
            trade['Item Count %d':format(1)] = v
        else
            local remaining = v
            for index = 1, ffxi.items.inventory.size do
                local item = ffxi.items.inventory[index]
                if item then
                    if remaining > 0 and res.items[item.id].en == k then
                        local count = 0
                        
                        if item.count >= remaining then
                            count = remaining
                        else
                            count = item.count
                        end
                        trade['Item Index %d':format(trade_index)] = index
                        trade['Item Count %d':format(trade_index)] = count
                        remaining = remaining - count
                        trade_count = trade_count + count
                        trade_index = trade_index + 1
                    end
                end
            end
            if remaining > 0 and not all then
                return false,'items'
            end
        end
    end

    trade['Number of Items'] = trade_index - 1
    packets.inject(trade)
    return true

end

function utils.can_fight(index)
    
    if not index then return false end
  
    local mob = ffxi.mob_array[index]
    
    if not mob
    or not mob.valid_target
    or mob.hpp == 0
    or not S{0,1}:contains(mob.status)
    or not utils.is_npc(mob.id) 
    or (mob.claim_id ~= 0 and (not ffxi.party[mob.claim_id]) 
        and (not ffxi.buffs['reive mark']) and (not ffxi.buffs['besieged']) 
        and (not ffxi.buffs['allied tags']) and (not ffxi.buffs['elvorseal'])) 
    then
        return false
    end

    return true
end

function utils.is_npc(id)
    if type(id) == "table" then
        id = id.id
    end

    if not id then return false end
    
    return ((id % (2^25)) >= 2^24)
end

function utils.request_pop(index)
    
    if index then
        local p = packets.new('outgoing', 0x16, {
            ["Target Index"] = index
        })
        packets.inject(p)
    end

end 

function utils.find_npc_index(name)

return npcs.Find(ffxi.zone,name).index
    
end
    

function utils.extract_pos(mob)
    if mob then
        return {mob.x or 0, mob.y or 0, mob.z or 0}
    end
end

function utils.normal(vector)
    local angle = math.atan2(vector[3],vector[1]) + math.pi/2
    local distance = utils.map_distance(vector,{0,0,0})
    return {distance*math.cos(angle),vector[2],distance*math.sin(angle)}

end

function utils.distance(a,b)
    if not a then return math.huge end
    
    b = b or utils.get_client_pos()
    
    -- return math.sqrt((a[1]-b[1])^2 + (a[2]-b[2])^2 + (a[3]-b[3])^2)
    return math.sqrt((a[1]-b[1])^2 + (a[3]-b[3])^2)
end

function utils.check_z(a,b,max)

    max = max or 5
    
    if not a or not b then return false end
    
    return math.abs(a[2] - b[2]) < max
end

function utils.map_distance(a,b)
    if not a then return math.huge end
    
    b = b or utils.get_client_pos()    
   
    
    return math.sqrt((a[1]-b[1])^2 + (a[3]-b[3])^2)
end

function utils.distance_to_mob(index)
    if tonumber(index) and ffxi.mob_array[tonumber(index)] then
        return utils.map_distance(ffxi.mob_array[tonumber(index)].pos, ffxi.player.pos)
    end

    return math.huge
end


function utils.get_client_pos()
    local player = windower.ffxi.get_mob_by_index(ffxi.player.index or -1)
    
    if player then 
        return {player.x,player.z,player.y}
    end
    
    return {0,0,0}

end

function utils.compare_points(a,b)
    if type(a) ~= "table" or type(b) ~= "table" then return false end
    
    return a[1] == b[1] and a[2] == b[2] and a[3] == b[3]
end

local path_base = 
[[return { 
    mode = "%s",
    zone = %s,
    path = %s,
}
]]

function utils.update_npcs()
    local exe_path = windower.addon_path..'npcs/NPCExtractor.exe'
    local sanitizer_path = windower.addon_path..'npcs/NpcSanitizer.py'
    if not windower.file_exists(exe_path) or 
        not windower.file_exists(sanitizer_path) 
    then
        notice("Npc files do not exist")
    end

    print(windower.windower_path)
    print(windower.addon_path)
    os.execute('start D:\\Games\\PlayOnline\\Windower4\\addons\\sync\\npcs\\NPCExtractor.exe')
    -- io.popen('Python '..sanitizer_path)
end

function utils.export_path(path, name)   
    
    local temp_path = table.copy(path)
    
    if not name or not tostring(name) then return end
    
    if not windower.dir_exists(windower.addon_path..'/data/') then
        windower.create_dir(windower.addon_path..'/data/')
    end
    
    if not windower.dir_exists(windower.addon_path..'/data/paths/exported') then
        windower.create_dir(windower.addon_path..'/data/paths/exported')
    end

    local file_path = '/data/paths/exported/' .. name .. '.lua'

    local export_file = file.new(file_path,true)
    
    if not export_file:exists() then
        export_file:create()
    end

    local point_str = {'{\n        '}

    for point in temp_path.points:it() do
        local index = #point_str
        if index > 1 and (index - 1) % 15 == 0 then
            point_str[index + 1] = '\n        {'
        else
            point_str[index + 1] = '{'
        end
        point_str[index + 2] = table.concat(point, ',')
        point_str[index + 3] = '}, '
    end

    point_str[#point_str + 1] = '\n    }'

    local export_str = path_base:format(temp_path.mode or 'linear', tostring(temp_path.zone) or 'false', table.concat(point_str))
    
    export_file:write(export_str)
    notice('File exported to ' .. file_path)
    
end

function utils.npc_item(item_id)
    local item,index = ffxi.items.inventory:with('id',item_id)
    if item then 
            local appraise = packets.new('outgoing', 0x84, {
            ["Count"] = item.count,
            ["Item"] = item_id,
            ["Inventory Index"] = index,
        })
        local sell = packets.new('outgoing', 0x85, {
            ["_unknown1"] = 1,
        })
        if not ffxi.appraisals[item_id] then
            packets.inject(appraise)
            ffxi.appraisals:add(item_id)
        end
        packets.inject(appraise)
        packets.inject(sell)
    else
        warning("Unable to locate an item with ID %d in your inventory.":format(item_id))
    end
end

local equip_inventories = S{0,8,10,11,12,'wardrobe','wardrobe2','wardrobe3','wardrobe4','inventory'}
local inventories = S{"inventory","safe","storage","temporary","locker","sack","case","satchel","storage","temporary","wardrobe","safe2","wardrobe2","wardrobe3","wardrobe4"}

function utils.find_item(name, equip_only, find_inventory)
    name = name or ""
    find_inventory = find_inventory or false

    if not find_inventory then
        for inventory,items in pairs(ffxi.items) do
            if not equip_only or equip_inventories[inventory] then 
                for index,item in pairs(items) do
                    if type(item) == 'table' and 
                        ((tonumber(name) and item.id == tonumber(name)) or
                        (res.items[item.id] or {}).en == name) then
                        return item,inventory,index
                    end
                end
            end
        end

        return false
    else
        for index,item in pairs(ffxi.items[find_inventory]) do
            if type(item) == 'table' and 
                ((tonumber(name) and item.id == tonumber(name)) or
                (res.items[item.id] or {}).en == name) 
            then
                return item,inventory,index
            end
        end
    end
    return false
end

function utils.find_in_inventory(name, equip_only, find_inventory)

    name = name or ""
    find_inventory = 0

    if not find_inventory then
        for inventory,items in pairs(ffxi.items) do
            if not equip_only or equip_inventories[inventory] then 
                for index,item in pairs(items) do
                    if type(item) == 'table' and 
                        ((tonumber(name) and item.id == tonumber(name)) or
                        (res.items[item.id] or {}).en == name) then
                        return item,inventory,index
                    end
                end
            end
        end
	   

        return false
    else
	
        for index,item in pairs(ffxi.items[find_inventory]) do
							   
											 
            if type(item) == 'table' and 
                ((tonumber(name) and item.id == tonumber(name)) or
                (res.items[item.id] or {}).en == name) 
            then
                return item,inventory,index
				   
            end
        end
    end

    return false
end

function utils.store_previous_party(party)
    utils.m_previous_party = party;
end

function utils.get_previous_party()
    local prev_party = utils.m_previous_party or T{}
    return prev_party
end

function utils.validate_closest_interaction(index, distance, max_index, blacklist)
    local mob = false
    local valid = false
    local poke_mob_name = false
    local attemped_mob_index = nil

    if not index then 
        return false
    elseif type(index) == "string" then
        poke_mob_name = index
        local client_mob = windower.ffxi.get_mob_by_name(index)
        mob = client_mob and ffxi.mob_array[client_mob.index] or nil
        attemped_mob_index = mob and mob.index or nil
    elseif type(index) == "number" then
        mob = ffxi.mob_array[index]
    end
    
    if mob and mob.valid_target and not blacklist:contains(mob.index) then
        local max_distance = distance or 10
        if utils.distance_to_mob(mob.index) <= max_distance then
            log("Valid mob(%d) at %d yalms":format(mob.index, utils.distance_to_mob(mob.index)))
            valid = true
            return true, mob
        end
    end

    if not valid and attemped_mob_index then
        log("Iterate to find a new mob")
        attempted_mob_index = attemped_mob_index + 1
        for i=attemped_mob_index, max_index do
            local try_mob = ffxi.mob_array[i]
            if try_mob and try_mob.valid_target then
                local try_mob_name = windower.ffxi.get_mob_by_index(try_mob.index).name
                log("Check Mob(%d) %s":format(i, (try_mob and try_mob_name) or ""))

                if try_mob_name == poke_mob_name and 
                    not blacklist:contains(try_mob.index) 
                then
                    local max_distance = distance or 10
                    if utils.distance_to_mob(try_mob.index) <= max_distance then
                        log("Valid mob(%d) at %d yalms":format(try_mob.index, utils.distance_to_mob(try_mob.index)))
                        valid = true
                        return true, try_mob
                    end
                end
            end
        end
    end
    
    if valid then
        warning('Too far away from NPC: ', index, distance)
        return true,nil
    else
        warning("Unable to locate NPC.")
        return false,nil
    end

end

function utils.log_hp_known(zone_id)
    local explorer_log_path = "/data/explorer_log.txt"
    local explorer_log = file.new(explorer_log_path,true)
    
    if not explorer_log:exists() then
        explorer_log:create()
    end

    explorer_log:append(tostring(zone_id) .. "\n")
end

function utils.navigate_closest(index, distance, max_index, blacklist)
    local spawned,mob = utils.validate_closest_interaction(index, distance, max_index, blacklist or L{})
    if spawned and mob then
        navigator.follow(mob.index)
        return true, mob.index
    elseif tonumber(index) and not spawned then
        log("Attempting to spawn: ", index)
        utils.request_pop(index)
    end

    return false
end

function utils.is_hp_known(zone_id)
    local explorer_log_path = "/data/explorer_log.txt"
    local explorer_log = file.new(explorer_log_path,true)
    
    if not explorer_log:exists() then
        explorer_log:create()
    end

    local lines = explorer_log:readlines()
    for i in ipairs(lines) do
        if tonumber(lines[i]) == zone_id then
            return true
        end
    end

    return false
end