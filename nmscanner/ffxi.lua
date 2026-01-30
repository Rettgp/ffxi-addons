require('queues')
packets = require('packets')
res = require('resources')
require('ci_table')

local _ffxi = {
    i = {},
    o = {},
}

ffxi = setmetatable({}, {  
    __index = function(t, k) 
            return rawget(_ffxi, k) or rawget(t, case_insensitive_filter(k)) 
        end,
    __newindex = function(t,k,v) 
            rawset(t, case_insensitive_filter(k),v) 
        end,
    __class = "FFXI"
})

local start_action_events = S{7,8,9}
local terminal_action_events = S{2,3,4,5,6,14}

local action_interrupted = S{78,84}

local action_message_interrupted = S{16,62}

local action_message_unable = S{12,17,18,34,35,40,47,48,49,55,56,71,72,76,78,84,87,88,89,90,91,92,94,95,96,104,106,111,128,154,155,190,191,192,193,198,199,215,216,217,218,219,220,233,246,247,307,308,313,315,316,325,328,337,338,346,347,348,349,356,410,411,428,443,444,445,446,514,516,517,518,523,524,525,547,561,568,569,574,575,579,580,581,649,660,661,662,665,666,700,701,717}


local function update_party_mob_array()
    local own_pt = ffxi.party[ffxi.player.id]
    for member in ffxi.party:it() do
        if member.index and ffxi.mob_array[member.index] then
            ffxi.mob_array[member.index].in_alliance = true
            if own_pt and own_pt.party and member.party then 
                --debugger.log(2, "ffxi", 'Update party mob_array  Set in party for Index: %s':format(tostring(member.index)))
                ffxi.mob_array[member.index].in_party = (own_pt.party == member.party)
            end
        end
    end    
end


-- Last packet sent before a zone out
_ffxi.o[0x00D] = function(id,data)
    ffxi.mob_array:clear()
    ffxi.appraisals:clear()
    ffxi.player.pos = T{0,0,0}
    ffxi.shop.items:clear()
    ffxi.shop.ready = false
    ffxi.guild.items:clear()
    ffxi.guild.ready = false
    for inventory in table.it(ffxi.items) do
        inventory:clear()
        inventory.count = 0
    end
    ffxi.items_ready = false
    ffxi.position_valid = false
end

-- Standard client, pos updates, target index, etc.
_ffxi.o[0x015] = function(id, _, data)
    local p = packets.parse('outgoing', data)
    ffxi.player.pos = T{p['X'],p['Z'],p['Y']}
    ffxi.position_valid = true
    ffxi.player.rotation = p['Rotation']
    if ffxi.mob_array[ffxi.player.index] then
        ffxi.mob_array[ffxi.player.index].pos = ffxi.player.pos
        ffxi.mob_array[ffxi.player.index].rotation = ffxi.player.rotation
    end
    ffxi.player.target_index = p['Target Index']
end

-- Zone in information
_ffxi.i[0x00A] =  function(id, data, modified)
    local p = packets.parse('incoming', modified or data)
    ffxi.available_spells = windower.ffxi.get_spells()
    local abilities = windower.ffxi.get_abilities()
    
    ffxi.safe_craft_ts = os.time() + 15

    ffxi.available_abilities = S(abilities.job_abilities)
    ffxi.available_weapon_skills = S(abilities.weapon_skills)
    ffxi.logged_in = true
    ffxi.player.id = p['Player']
    ffxi.player.index = p['Player Index']
    ffxi.previous_zone = ffxi.zone
    ffxi.zone = p['Zone']
    ffxi.weather = p['Weather']
    ffxi.player.name = p['Player Name']
    ffxi.player.main_job = p['Main Job']
    ffxi.player.sub_job = p['Sub Job']
    ffxi.player.levels = case_insensitive_table()
	for i = 1, 22 do
        local level = p['%s Level':format(res.jobs[i].en)]
        ffxi.player.levels[res.jobs[i].ens] = level 
	end
	ffxi.player.job_unlocked = case_insensitive_table()
	for i = 1, 22 do
        local level = p['%s Level':format(res.jobs[i].en)]
        ffxi.player.job_unlocked[res.jobs[i].ens] = level ~= 0 
	end        
    
    -- You don't get party updates if you're solo, create an entry
    if not ffxi.party[p['Player']] then
        ffxi.party[p['Player']] = case_insensitive_table()            
        ffxi.party[p['Player']].id = p['Player']
        ffxi.party[p['Player']].index = p['Player Index']
        ffxi.party[p['Player']].zone = p['Zone']
        ffxi.party[p['Player']].party = 0
        ffxi.party[p['Player']].party_leader = false
        ffxi.party[p['Player']].alliance_leader = false
        ffxi.party[p['Player']].name = p['Player Name']
        ffxi.party[p['Player']].main_job_level = windower.ffxi.get_player().main_job_level
    end
    ffxi.mob_array[p['Player Index']] = case_insensitive_table()
    ffxi.mob_array[p['Player Index']].index = p['Player Index']
    ffxi.mob_array[p['Player Index']].id = p['Player']
    ffxi.mob_array[p['Player Index']].valid_target = true

    ffxi.mog_house = data:unpack('c',0x81) == 1

    if ffxi.zone_pos_override and ffxi.zone_pos_override.name == res.zones[p['Zone']].en then
        p['X'] = ffxi.zone_pos_override.x
        p['Z'] = ffxi.zone_pos_override.z
        p['Y'] = ffxi.zone_pos_override.y
        log(p['X'], p['Z'], p['Y'])
        coroutine.yield(packets.build(p))
        ffxi.zone_pos_override = false
    end
end

-- added this for updating spell lists. Good for learning spells.
_ffxi.i[0x0AA] = function(id,data)
    ffxi.available_spells = windower.ffxi.get_spells()
  end
  
-- Was trying to use this for logged in, but you
-- don't actually get this packet on your initial login?
_ffxi.i[0x00B] = function(id,data)
    local p = packets.parse('incoming', data)
    if p['Type'] == 1 then
        ffxi.logged_in = false
    else
        ffxi.logged_in = true
    end
    
    ffxi.ip = '%d.%d.%d.%d':format('I':pack(p['IP']):unpack('CCCC'))
    ffxi.port = p['Port']
end


--PC Update
_ffxi.i[0x00D] = function(id,data)
    local p = packets.parse('incoming', data)
    
    local index = p['Index']
    
    if not ffxi.mob_array[index] then
        ffxi.mob_array[index] = case_insensitive_table()
        ffxi.mob_array[index].index = index
    end
    
    ffxi.mob_array[index].pc = true
    ffxi.mob_array[index].id = p['Player']
    
    if p['Update Position'] and ffxi.mob_array[index] then -- Position, rotation, target
        ffxi.mob_array[index].pos = T{p['X'],p['Z'],p['Y']}
        ffxi.mob_array[index].rotation = p['Rotation']
        ffxi.mob_array[index].valid_target = true
    end   
        
    if p['Update Vitals'] and ffxi.mob_array[index] then 
        ffxi.mob_array[index].hpp = p['HP %']
        ffxi.mob_array[index].status = p['Status']
    end
    
    if p['Update Name'] and ffxi.mob_array[index] then
        ffxi.mob_array[index].name = p['Character Name']
    end
    
    if p['Despawn'] and ffxi.mob_array[index] then
         ffxi.mob_array[index].valid_target = false
    end
end

-- NPC Update
_ffxi.i[0x00E] = function(id,data)
    local p = packets.parse('incoming', data)
    
    local index = p['Index']
    
    if not ffxi.mob_array[index] then
        ffxi.mob_array[index] = case_insensitive_table()     
    end

    ffxi.mob_array[index].index = index
    ffxi.mob_array[index].id = p['NPC']
    ffxi.mob_array[index].model = p['Model']
    ffxi.mob_array[index].name = windower.ffxi.get_mob_list()[index]

    
    local flags = {
        (p['Mask'] % 2) >= 1,       -- Position, Flags
        (p['Mask'] % 4) >= 2,       -- Claimer ID
        (p['Mask'] % 8) >= 4,       -- HP, Status
        (p['Mask'] % 16) >= 8,      -- Name (Not used by client...)    
        (p['Mask'] % 32) >= 16,     -- 
        (p['Mask'] % 64) >= 32,     -- Despawn / out of range
        (p['Mask'] % 128) >= 64,
        (p['Mask'] % 256) >= 128,
    
    }
    
    if flags[1] and ffxi.mob_array[index] then
        ffxi.mob_array[index].pos = T{p['X'],p['Z'],p['Y']}
        ffxi.mob_array[index].rotation = p['Rotation']
        ffxi.mob_array[index].valid_target = true

        if p['_unknown2'] % 4 >= 2 then
             ffxi.mob_array[index].valid_target = false
        end
    end
        
    if flags[2] and ffxi.mob_array[index] then 
         ffxi.mob_array[index].claim_id = p['Claimer']
    end 
    
    if flags[3] and ffxi.mob_array[index] then
        ffxi.mob_array[index].hpp = p['HP %']
        ffxi.mob_array[index].status = p['Status']
        if p['HP %'] == 0 then
            ffxi.mob_array[index].attacking = false
        end
    end

    if flags[4] and p['Index'] > 0x400 then
        ffxi.mob_array[index].name = p['Name']
    end

    if flags[6] then
         ffxi.mob_array[index].valid_target = false
    end 

end


--Inventory sizes, -1 because of gil slot
_ffxi.i[0x01C] = function(id,data)
    local p = packets.parse('incoming', data)
    ffxi.items.inventory.size = p['Inventory Size'] - 1
    ffxi.items.safe.size = p['Safe Size'] - 1
    ffxi.items.storage.size = p['Storage Size'] - 1
    ffxi.items.temporary.size = p['Temporary Size'] - 1
    ffxi.items.locker.size = p['Locker Size'] - 1
    ffxi.items.satchel.size = p['Satchel Size'] - 1
    ffxi.items.sack.size = p['Sack Size'] - 1
    ffxi.items.case.size = p['Case Size'] - 1
    ffxi.items.wardrobe.size = p['Wardrobe Size'] - 1
    ffxi.items.safe2.size = p['Safe 2 Size'] - 1
    ffxi.items.wardrobe2.size = p['Wardrobe 2 Size'] - 1
    ffxi.items.wardrobe3.size = p['Wardrobe 3 Size'] - 1
    ffxi.items.wardrobe4.size = p['Wardrobe 4 Size'] - 1
    ffxi.items.wardrobe5.size = p['Wardrobe 5 Size'] - 1
	ffxi.items.wardrobe6.size = p['Wardrobe 6 Size'] - 1
	ffxi.items.wardrobe7.size = p['Wardrobe 7 Size'] - 1
	ffxi.items.wardrobe8.size = p['Wardrobe 8 Size'] - 1
	ffxi.items.recycle.size = p['Recycle Bin Size'] - 1
end

--Inventory complete
_ffxi.i[0x01D] = function(id, data)
    local p = packets.parse('incoming', data)
    if p['Flag'] == 1 and p['Bag'] == 18 then
        ffxi.items_ready = true
    end
end

-- Modify Inventory
_ffxi.i[0x01E] = function(id,data)
    local p = packets.parse('incoming', data)
    local index = p['Index']
    local bag_index = p['Bag']
    if bag_index == 0 and index == 0 then
        ffxi.gil = p['Count']
    else
        local bag = ffxi.items[bag_index]
        if bag then
            if p['Count'] > 0 then       
                if not bag[index] then
                    if index <= bag.size then
                        bag[index] = T{}
                    else 
                        warning("0x01E Item update for index: %d - Bag Size: %d":format(index, bag.size))
                    end
                    bag.count = bag.count + 1
                end
                if index <= bag.size then
                    bag[index].bag = bag_index
                    bag[index].status = p['Status']
                    bag[index].count = p['Count']
                end
            elseif p['Count'] == 0 then
                bag[index] = nil
                bag.count = bag.count - 1
            end
        end
    end
end

-- Item Status
_ffxi.i[0x01F] = function(id,data)
    local p = packets.parse('incoming', data)
    local index = p['Index']
    local bag_index = p['Bag']
    if bag_index == 0 and index == 0 then
        ffxi.gil = p['Count']
    else
        local bag = ffxi.items[bag_index]
        if bag then
            if p['Count'] > 0 then       
                if not bag[index] then
                    if index <= bag.size then
                        bag[index] = T{}
                    else 
                        warning("0x01F Item update for index: %d - Bag Size: %d":format(index, bag.size))
                    end
                    bag.count = bag.count + 1
                end
                if index <= bag.size and p['Item'] ~= 0 then
                    bag[index].bag = bag_index
                    bag[index].id = p['Item']
                    bag[index].status = p['Status']
                    bag[index].count = p['Count']
                end
             elseif p['Count'] == 0 then
                bag[index] = nil
                bag.count = bag.count - 1
            end
        end
    end
end

-- Populate items
_ffxi.i[0x020] = function(id,data)
    local p = packets.parse('incoming', data)
    local index = p['Index']
    local bag_index = p['Bag']
    if p['Bag'] == 0 and p['Index'] == 0 then
        ffxi.gil = p['Count']
    else
        local bag = ffxi.items[bag_index]
        if bag then
            if p['Count'] > 0 then       
                if not bag[index] then
                    if index <= bag.size then
                        bag[index] = T{}
                    else 
                        warning("0x020 Item update for index: %d - Bag Size: %d":format(index, bag.size))
                    end
                    bag.count = bag.count + 1
                end
                if index <= bag.size and p['Item'] ~= 0 then
                    bag[index].bag = bag_index
                    bag[index].id = p['Item']
                    bag[index].name = res.items[p['Item']].en
                    bag[index].status = p['Status']
                    bag[index].count = p['Count']
                    bag[index].bazaar = p['Bazaar']
                    bag[index].extdata = p['ExtData']
                    bag[index].index = index
                end
            elseif p['Count'] == 0 then
                bag[index] = nil
                bag.count = bag.count - 1
            end
        end
    end
end

_ffxi.i[0x037] = function(id,data)
    local abilities = windower.ffxi.get_abilities()
    ffxi.available_abilities = S(abilities.job_abilities)
    ffxi.available_weapon_skills = S(abilities.weapon_skills)
    ffxi.player.id = data:unpack('I', 0x25)
    local unk, pet_index = data:unpack('b3b16', 0x35)
    ffxi.pet_index = pet_index
    ffxi.player.status = data:unpack('C', 0x31)
    ffxi.indi_buff = data:unpack('b7', 0x59)
end

-- Spawn/Despawn info
_ffxi.i[0x038] = function(id,data)
    local p = packets.parse('incoming', data)
    local index = p['Mob Index']

    if p['Type'] == "kesu" and ffxi.mob_array[index] then
        ffxi.mob_array[index].valid_target = false
    elseif p['Type'] == "deru" and not ffxi.mob_array[index] then 
        ffxi.mob_array[index] = case_insensitive_table()
    end
end

_ffxi.i[0x03C] = function(id,data)
    local p = packets.parse('incoming',data)

    if p['_zero1'] == 0 then
        ffxi.shop.items:clear()
    end

    for i = 1, 27 do
        local item = p['Item %d':format(i)]
        if not item then break end
        ffxi.shop.items[p['Shop Slot %d':format(i)]] = { item = item, price = p['Price %d':format(i)]}
    end

    ffxi.shop.ready = os.clock() + 3
end

-- inbox information
_ffxi.i[0x04B] = function(id,data)
    local p = packets.parse('incoming',data)
	
	if p['Type'] == 6 or p['Type'] == 1 then
		ffxi.inbox[p['Delivery Slot']] = p['Item'] 
		
	end		
end

-- Equip change
_ffxi.i[0x050] = function(id,data)
    local p = packets.parse('incoming', data)
    
    if p['Inventory Index'] == 0 then
        ffxi.equipment[p['Equipment Slot']] = nil
     else
        local item = ffxi.items[p['Inventory Bag']][p['Inventory Index']]
        if item then          
            ffxi.equipment[p['Equipment Slot']] = item
        end
     end
end

-- Key Items
_ffxi.i[0x055] = function(id,data)
    local available = T{data:unpack('b1':rep(512), 5)}
    
    for i = 1, #available do
        local index = ((512* data:byte(133)) - 1) + i
        if available[i] == 1 then
            ffxi.key_items:add(index)
        else
            ffxi.key_items:remove(index)
        end
    end
end 

local flagged_quests = {
    [0x0050] = 'San d\'Oria',
    [0x0058] = 'Bastok',
    [0x0060] = 'Windurst',
    [0x0068] = 'Jeuno',
    [0x0070] = 'Other Areas',
    [0x0078] = 'Outlands',
    [0x0088] = 'Crystal War',
    [0x00E0] = 'Abyssea',
    [0x00F0] = 'Adoulin',
    [0x0100] = 'Coalition', 
}

local completed_quests = {
    [0x0090] = 'San d\'Oria',
    [0x0098] = 'Bastok',
    [0x00A0] = 'Windurst',
    [0x00A8] = 'Jeuno',
    [0x00B0] = 'Other Areas',
    [0x00B8] = 'Outlands',
    [0x00C8] = 'Crystal War',
    [0x00E0] = 'Abyssea',
    [0x00F8] = 'Adoulin',
    [0x0108] = 'Coalition', 
}

local bit_flags = function(data)
    return T{data:unpack('b1':rep(#data * 8))}:key_map(
        function(k) return k - 1 end):filter(function(v) return (v == 1) end):keyset()
end

function to_set(data)
    return {data:unpack('q64':rep(#data/4))}
end

_ffxi.i[0x56] = function(id, data)

    local p = packets.parse('incoming', data)

    local type = bit.band(p['Type'], 0xFFFF)

    if type == 0x0080 then
        ffxi.missions['Treasures of Aht Urhgan'].current = p['Current TOAU Mission']
        ffxi.missions['Wings of the Goddess'].current = p['Current WOTG Mission']
        return
    elseif type == 0x00C0 then
        return
    elseif type == 0x00D0 then
        ffxi.missions.nations[0].completed = bit_flags(p['Completed San d\'Oria Missions'])
        ffxi.missions.nations[1].completed = bit_flags(p['Completed Bastok Missions'])
        ffxi.missions.nations[2].completed = bit_flags(p['Completed Windurst Missions'])
        ffxi.missions['Rize of the Zilart'].completed = bit_flags(p['Completed Zilart Missions'])
        return
    elseif type == 0x00D8 then
        ffxi.missions['Treasures of Aht Urhgan'].completed = bit_flags(p['Completed TOAU Missions'])
        ffxi.missions['Wings of the Goddess'].completed = bit_flags(p['Completed WOTG Missions'])
    elseif type == 0xFFFF then
        ffxi.nation = p['Nation']
        ffxi.missions.nation = ffxi.missions.nations[ffxi.nation]
        ffxi.missions.nation.current = p['Current Nation Mission']
        ffxi.missions['Rize of the Zilart'].current = p['Current ROZ Mission']
        ffxi.missions['Chains of Promathia'].current = p['Current COP Mission']
        ffxi.missions['Rhapsodies of Vana\'diel'].current = p['Current ROV Mission']
        ffxi.missions['Seekers of Adoulin'].current = p['Current SOA Mission']
        return
    end

    local style,key

    if table.containskey(flagged_quests, type) then
        key = flagged_quests[type]
        style = 'flagged'
    elseif table.containskey(completed_quests, type) then
        key = completed_quests[type]
        style = 'completed'
    end

    if not key or not style then return end

    ffxi.quests[key][style] = bit_flags(p['Quest Flags'])
end

-- Weather in case of questing
_ffxi.i[0x57] = function(id,data)
    local p = packets.parse('incoming', data)       
    ffxi.weather = p['Weather']
end

-- Status update
_ffxi.i[0x61] = function(id,data)
    local p = packets.parse('incoming', data)
    ffxi.player.max_hp = p['Maximum HP']
    ffxi.player.max_mp = p['Maximum MP']
    ffxi.player.main_job = p['Main Job']
    ffxi.player.sub_job = p['Sub Job']
    ffxi.player.main_job_level = p['Main Job Level']
    ffxi.player.sub_job_level = p['Sub Job Level']
    ffxi.current_exp = p['Current EXP']
    ffxi.required_exp = p['Required EXP']
    ffxi.current_ep = p['Current Exemplar Points']
    ffxi.required_ep = p['Required Exemplar Points']
end

_ffxi.i[0x62] = function(id,data)
    
    for skill in res.skills:it() do
        local offset = 129 + (skill.id * 2)
        if skill.id < 48 then
            local level,capped = data:unpack('b15b1',offset)
            ffxi.skills[skill.id].level = level
            ffxi.skills[skill.id].capped = capped == 1
            ffxi.skills[skill.id].rank = 0
        else
            local rank,level,capped = data:unpack('b5b10b1',offset)
            ffxi.skills[skill.id].level = level
            ffxi.skills[skill.id].capped = (capped == 1)
            ffxi.skills[skill.id].rank = rank
        end
    end    
end

ffxi.merits = case_insensitive_table()

_ffxi.i[0x8c] = function(id,data)
    
local p = packets.parse('incoming',data)
local count = p['Count']
  for i = 1, count do
	ffxi.merits[p['Merit '..i]] = {
        name = res.merit_points[p['Merit '..i]].en,
        value = p['Value '..i],
        cost = p['Next Cost '..i] 
        }
end
end

-- Lots of info from this packet, buffs, job points, monstrosity, merits
_ffxi.i[0x63] = function(id,data)
    local p = packets.parse('incoming', data)
    
    if p['Order'] == 2 then
        ffxi.current_merits = data:byte(11)%128
        ffxi.maximum_merits = data:byte(0x0D)%128
        ffxi.level_capped = bit.band(0x40, data:byte(0x0C)) > 0
    elseif p['Order'] == 5 then
        for i = 1, 22 do
            local offset = ((i - 1) * 6) + 19
            ffxi.job_points[i].cp = data:unpack('H', offset)
            ffxi.job_points[i].current = data:unpack('H', offset + 2)
            ffxi.job_points[i].spent = data:unpack('H', offset + 4)
        end
    elseif p['Order'] == 9 then
        ffxi.buffs = case_insensitive_table()
        ffxi.buff_start_time = case_insensitive_table()
        for i = 1,32 do
            local buff = p['Buffs %d':format(i)]
            
            if res.buffs[buff] and res.buffs[buff].english then
                if not ffxi.buffs[buff] then
                    ffxi.buffs[buff] = 1
                    ffxi.buffs[res.buffs[buff].english] = 1
                else
                    ffxi.buffs[buff] = ffxi.buffs[buff] + 1
                    ffxi.buffs[res.buffs[buff].english] = ffxi.buffs[res.buffs[buff].english] + 1
                end            
            end     
        end

        for event in ffxi.buff_event_handlers:it() do
            event()
        end
    end
end

_ffxi.i[0x067] = function(id,data)
    local p = packets.parse('incoming',data)

    if p['Message Type'] == 4 then
        local i = p['Pet Index']
        if ffxi.mob_array[i] then
            ffxi.mob_array[i].hpp = p['Current HP%']
            ffxi.mob_array[i].mpp = p['Current MP%']
            ffxi.mob_array[i].tp = p['Pet TP']
        end
    end

end

_ffxi.i[0x068] = function(id,data)
    _ffxi.i[0x67](id,data)
end

-- Party Buffs
_ffxi.i[0x076] = function(id,data)
    local p = packets.parse('incoming', data)
    for i =1,5 do
        local member = ffxi.party[p['ID %d':format(i)]]
        if member then
            member.buffs = case_insensitive_table()
            local buffs = p['Buffs %d':format(i)]
            local mask = L{p['Bit Mask %d':format(i)]:unpack('b2':rep(32))}
            for j=1,32 do
                local test_buff = buffs:byte(j)
                if test_buff ~= 0xFF then
                    local buff = test_buff + (mask[j] * 0x100)
                    if res.buffs[buff] and res.buffs[buff].english then
                        if not member.buffs[buff] then
                            member.buffs[buff] = 1
                            member.buffs[res.buffs[buff].english] = 1
                        else
                            member.buffs[buff] = member.buffs[buff] + 1
                            member.buffs[res.buffs[buff].english] = member.buffs[res.buffs[buff].english] + 1
                        end            
                    end  
                end
            end
        end
        
    end
end

_ffxi.i[0x083] = function(id,data)
    local p = packets.parse('incoming',data)

    if p['Order'] == 0 then
        ffxi.guild.items:clear()
        ffxi.guild.ready = false
    end

    for i = 1, p['Item Count'] do
        local item = p['Item %d':format(i)]
        local stock = p['Current Stock %d':format(i)]

        ffxi.guild.items[item] = stock
    end

    ffxi.guild.ready = os.clock() + 5
end

_ffxi.i[0x08D] = function(id,data)
    for i = 1, 64 do
        local offset = 5 + ((i - 1) * 4)
        local index,job_id = data:unpack('b5b11', offset)
        local next_level,current = data:unpack('b10b6', offset + 2)
        if job_id and job_id ~= 0 and ffxi.job_points[job_id] then
            ffxi.job_points[job_id].details[index + 1] = current
        end
    end
end

local party_meta = {  
    __index = function(t, k) 
            return rawget(t, case_insensitive_filter(k)) or 
                rawget(ffxi.mob_array[rawget(t, 'index')] or {}, case_insensitive_filter(k))
        end,
    __newindex = function(t,k,v) 
            rawset(t, case_insensitive_filter(k),v) 
        end,
    __class = "FFXI"
}

_ffxi.i[0x0C8] = function(id,data)
    local p = packets.parse('incoming', data)
    local ids = S{}
    for i = 1,18 do
        local id = p['ID %d':format(i)]
        --debugger.log(2, "ffxi", '0x0C8 ID: %s Flags: %s':format(tostring(id), tostring(p['Flags %d':format(i)])))
        if id ~= 0 then
            ids:add(id)

            local raw_flags = p['Flags %d':format(i)]
            local party_num = (raw_flags % 4)
            local flags = {
                (raw_flags % 8) >= 4,
                (raw_flags % 16) >= 8,
            }
            
            local member = ffxi.party[id] or setmetatable({}, party_meta)
            table.update(member,{
                id = id, 
                index = (p['Index %d':format(i)] ~= 0 and p['Index %d':format(i)]) or nil, 
                zone = (p['Zone %d':format(i)] ~= 0 and p['Zone %d':format(i)]) or nil,
                party = party_num,
                party_leader = flags[1],
                alliance_leader = flags[2],
            })

            ffxi.party[id] = member
        end
    end
    local remove_these = S(table.keyset(ffxi.party)):diff(ids)
    
    for id in remove_these:it() do
        local temp = ffxi.party[id]
        if temp.index and ffxi.mob_array[temp.index] then
            ffxi.mob_array[temp.index].in_alliance = false
            ffxi.mob_array[temp.index].in_party = false
        end
        ffxi.party[id] = nil
    end

    update_party_mob_array()
end

_ffxi.i[0x0DD] = function(id,data)
    local p = packets.parse('incoming', data)

    local member = ffxi.party[p['ID']]
    if member then
        --debugger.log(2, "ffxi", '0x0DD Valid Party Member ID: %s':format(tostring(p['ID'])))
            local party = (p['Flags'] % 4)
            local flags = {
                (p['Flags'] % 8) >= 4,
                (p['Flags'] % 16) >= 8,
            }
        
        
        table.update(member,{
            id = p['ID'], 
            index = (p['Index'] ~= 0 and p['Index']) or nil, 
            zone = (p['Zone'] ~= 0 and p['Zone']) or nil,
            name = p['Name'],
            job = p['Main job'],
            party = party,
            party_leader = flags[1],
            alliance_leader = flags[2],
            temporary = false,
            main_job_level = p['Main job level']
        })

        update_party_mob_array()
    end
end

_ffxi.i[0x0DF] = function(id,data)
    local p = packets.parse('incoming', data)
    
    if ffxi.player.index == p['Index'] then
        ffxi.player.hp = p['HP']
        ffxi.player.mp = p['MP']
        ffxi.player.tp = p['TP']
        ffxi.player.hpp = p['HPP']
        ffxi.player.mpp = p['MPP']
    end
    
    if not ffxi.mob_array[p['Index']] then
        ffxi.mob_array[p['Index']] = case_insensitive_table()
        ffxi.mob_array[p['Index']].index = p['Index']
    end

    ffxi.mob_array[p['Index']].hpp = p['HPP']     

    update_party_mob_array()
end

_ffxi.i[0x111] = function(id,data)
    
    local p = packets.parse('incoming', data)
    
    ffxi.roe.active:clear()
    
    for i = 1, 30 do
        local id = p['RoE Quest ID %d':format(i)]
        if id ~= 0 then
            ffxi.roe.active[id] = p['RoE Quest Progress %d':format(i)]
        end
    end

end

_ffxi.i[0x112] = function(id,data)
    
    local p = packets.parse('incoming', data)
    
    local complete = T{p['RoE Quest Bitfield']:unpack('b1':rep(1024))}
    ffxi.roe.complete:update(complete:key_map(
        function(k)
             return (k + 1024*p['Order']) - 1 
        end):map(
        function(v) 
            return (v == 1)
        end))
end

_ffxi.i[0x113] = function(id,data,modified,injected,blocked)
    
    ffxi.currencies.gp.woodworking = data:unpack('i', 0x25)
    ffxi.currencies.gp.smithing = data:unpack('i', 0x29)
    ffxi.currencies.gp.goldsmithing = data:unpack('i', 0x2D)
    ffxi.currencies.gp.clothcraft = data:unpack('i', 0x31)
    ffxi.currencies.gp.leathercraft = data:unpack('i', 0x35)
    ffxi.currencies.gp.bonecraft = data:unpack('i', 0x39)
    ffxi.currencies.gp.alchemy = data:unpack('i', 0x3D)
    ffxi.currencies.gp.cooking = data:unpack('i', 0x41)

    local p = packets.parse('incoming',data)
    ffxi.currencies.ap = 
        T{
            p['Assault Points (Leujaoam Sanctum)'], 
            p['Assault Points (M.J.T.G.)'], 
            p['Assault Points (Lebros Cavern)'], 
            p['Assault Points (Periqia)'], 
            p['Assault Points (Ilrusi Atoll)']
        }

    ffxi.currencies.is = p['Imperial Standing']
    ffxi.currencies.cp = p['Conquest Points (San d\'Oria)']
    ffxi.currencies.login = p['Login Points']
end

_ffxi.i[0x118] = function(id,data,modified,injected,blocked)

    local p = packets.parse('incoming',data)
    ffxi.currencies.imp = p['Coalition Imprimaturs']
    ffxi.currencies.bayld = p['Bayld']

end

_ffxi.i[0x119] = function(id,data,modified,injected,blocked)

    
    local p = packets.parse('incoming', data)
    for i = 1, 31 do 
        local recast = p['Duration %d':format(i)]
        if recast > 0 then
            ffxi.ability_recasts[p['Recast %d':format(i)]] = os.clock() + recast
        end
    end
end

function _ffxi.inc_packet_parser(id,data,modified,injected,blocked)

    if injected then return end
    
    if _ffxi.i[id] then
        return _ffxi.i[id](id,data,modified)
    end
end

function _ffxi.out_packet_parser(id,data,modified,injected,blocked)
    if injected then return end

    if _ffxi.o[id] then
        return _ffxi.o[id](id,data,modified)
    end
end

function _ffxi.spawn_at(name, x, z, y)
    ffxi.zone_pos_override = {
        name = name,
        x = x,
        z = z,
        y = y,
    }
end


--[[
FFXI initializaiton.
]]

do
    ffxi.logged_in = false
    ffxi.safe_craft_ts = os.time() + 30
    ffxi.appraisals = S{}
    ffxi.pet_index = false
    ffxi.current_merits = 0
    ffxi.maximum_merits = 10
    ffxi.currencies = case_insensitive_table()
    ffxi.currencies.gp = case_insensitive_table()
    ffxi.currencies.ap = case_insensitive_table()
    ffxi.buff_event_handlers = Q{}

    ffxi.shop = T{
        items = T{},
        ready = false,
    }
    ffxi.guild = T{
        items = T{},
        ready = false,
    }
    
    ffxi.skills = T{}
    
    for skill in res.skills:it() do
        ffxi.skills[skill.id] = case_insensitive_table()
        ffxi.skills[skill.id].name = skill.en
    end
    
    ffxi.roe = T{
        active = T{},
        complete = T{},
    }
    
    ffxi.job_points = T{
        [1] = T{details = T{}},
        [2] = T{details = T{}},
        [3] = T{details = T{}},
        [4] = T{details = T{}},
        [5] = T{details = T{}},
        [6] = T{details = T{}},
        [7] = T{details = T{}},
        [8] = T{details = T{}},
        [9] = T{details = T{}},
        [10] = T{details = T{}},
        [11] = T{details = T{}},
        [12] = T{details = T{}},
        [13] = T{details = T{}},
        [14] = T{details = T{}},
        [15] = T{details = T{}},
        [16] = T{details = T{}},
        [17] = T{details = T{}},
        [18] = T{details = T{}},
        [19] = T{details = T{}},
        [20] = T{details = T{}},
        [21] = T{details = T{}},
        [22] = T{details = T{}},
    }
    
    --[[
            Party 
    ]]
        
    ffxi.party = T{}
    
    --[[       
            Player info, grab vitals since these are updated across multiple
            packets
    ]]
    
    local temp_player = windower.ffxi.get_player()
    local player_info = windower.ffxi.get_info()
    ffxi.zone = player_info.zone
    ffxi.previous_zone = player_info.zone
    
    ffxi.player = case_insensitive_table()

    if temp_player then
        if temp_player.vitals then
            ffxi.player.hpp = temp_player.vitals.hpp
            ffxi.player.mpp = temp_player.vitals.mpp
            ffxi.player.hp = temp_player.vitals.hp
            ffxi.player.mp = temp_player.vitals.mp
            ffxi.player.max_hp = temp_player.vitals.max_hp
            ffxi.player.max_mp = temp_player.vitals.max_mp
            ffxi.player.tp = temp_player.vitals.tp
        end
        
    --[[
            Buffs
    ]]

        ffxi.buffs = case_insensitive_table()
        ffxi.buff_start_time = case_insensitive_table()
        for i,v in pairs(temp_player.buffs) do
            if res.buffs[v] and res.buffs[v].english then
                if not ffxi.buffs[v] then
                    ffxi.buffs[v] = 1
                    ffxi.buffs[res.buffs[v].english:lower()] = 1
                else
                    ffxi.buffs[v] = ffxi.buffs[v] + 1
                    ffxi.buffs[res.buffs[v].english:lower()] = ffxi.buffs[res.buffs[v].english:lower()] + 1
                end                
            end
        end
        for event in ffxi.buff_event_handlers:it() do
            event()
        end
    end

    
    --[[   
            Inventories; the inventories are updated through many sequential
            packets, so it is impossible to know the state through packets
            unless loaded before login
    ]]
    
    local temp_items = windower.ffxi.get_items()
    local inventories = S{"inventory","safe","storage","temporary","locker","sack","case","satchel","storage","temporary","wardrobe","safe2","wardrobe2","wardrobe3","wardrobe4","wardrobe5","wardrobe6","wardrobe7","wardrobe8","recycle"}

    ffxi.key_items = S{}

    for k,v in pairs(windower.ffxi.get_key_items()) do
        ffxi.key_items:add(v)
    end

    local reverse_equip_map = {
        ['main'] = 0,
        ['sub'] = 1,
        ['ammo'] = 2,
        ['range'] = 3,
        ['head'] = 4,
        ['body'] = 5,
        ['hands'] = 6,
        ['legs'] = 7,
        ['feet'] = 8,
        ['neck'] = 9,
        ['waist'] = 10,
        ['left_ear'] = 11,
        ['right_ear'] = 12,
        ['left_ring'] = 13,
        ['right_ring'] = 14,
        ['back'] = 15, 
    }
    
    ffxi.equipment = setmetatable({}, {
        __index = function(t, k)
                local new_key = type(k) == 'string' and reverse_equip_map[k:lower()] or k
                return rawget(t, new_key)
            end,
        __newindex = function(t, k, v)
            local new_key = type(k) == 'string' and reverse_equip_map[k:lower()] or k
            return rawset(t, new_key, v)
        end
    })

    local reverse_inventory_map = {
        ['inventory'] = 0,
        ['safe'] = 1,
        ['storage'] = 2,
        ['temporary'] = 3,
        ['locker'] = 4,
        ['satchel'] = 5,
        ['sack'] = 6,
        ['case'] = 7,
        ['wardrobe'] = 8,
        ['safe2'] = 9,
        ['wardrobe2'] = 10,
        ['wardrobe3'] = 11,
        ['wardrobe4'] = 12,
        ['wardrobe5'] = 13,
		['wardrobe6'] = 14,
		['wardrobe7'] = 15,
		['wardrobe8'] = 16,
		['recycle'] = 17,
    }


    ffxi.items = setmetatable({}, {
        __index = function(t, k)
                local new_key = type(k) == 'string' and reverse_inventory_map[k:lower()] or k
                return rawget(t, new_key)
            end,
        __newindex = function(t, k, v)
            local new_key = type(k) == 'string' and reverse_inventory_map[k:lower()] or k
            return rawset(t, new_key, v)
        end
    })
    
    for inv in inventories:it() do
        if not ffxi.items[inv] then ffxi.items[inv] = T{} end
        local items = temp_items[inv]
        for i = 1, 80 do 
            local item = items[i]
            if item and item.id ~= 0 then   
                ffxi.items[inv][i] = T{}
                ffxi.items[inv][i]:update(item)
                ffxi.items[inv][i].name = res.items[item.id].en
                ffxi.items[inv][i].index = i
            end
        end
        ffxi.items[inv].size = items.size
        ffxi.items[inv].count = items.count
    end

    ffxi.inbox = case_insensitive_table()

    ffxi.gil = temp_items.gil

    for slot in L{"ammo","back","body","feet","hands","head","left_ear","legs","left_ring","main","neck","range","right_ear","right_ring","sub","waist"}:it() do
        local bag = temp_items.equipment["%s_bag":format(slot)]
        local index = temp_items.equipment[slot]
        ffxi.equipment[slot] = ffxi.items[bag][index]
    end

    ffxi.items_ready = true
    ffxi.position_valid = true
    
    --[[
            Mob array
    ]]
    
    ffxi.mob_array = T{}
    
    for i,v in pairs(windower.ffxi.get_mob_array()) do
        ffxi.mob_array[v.index] = {
            ts = os.clock(),
            pos = {v.x,v.z,v.y},
            attacking = false,
            id = v.id,
            index = v.index,
            hpp = v.hpp,
            status = v.status,
            claim_id = v.claim_id,
            name = v.name,
            valid_target = v.valid_target
        }
    end

    --[[
        Quest and Missions
    ]]

    local quest_types = L{'San d\'Oria','Bastok','Windurst','Jeuno','Other Areas','Outlands','Crystal War','Abyssea','Adoulin','Coalition'}
    local mission_types = L{'Rize of the Zilart','Chains of Promathia','Treasures of Aht Urhgan','Wings of the Goddess','Seekers of Adoulin','Rhapsodies of Vana\'diel',}

    ffxi.quests = case_insensitive_table()
    ffxi.missions = case_insensitive_table()
    ffxi.nation = false

    for q in quest_types:it() do
        ffxi.quests[q] = {}
    end

    for m in mission_types:it() do
        ffxi.missions[m] = {}
    end

    ffxi.missions.nations = {
        [0] = {},
        [1] = {},
        [2] = {},
    }
    
    
    --[[
            Recasts
    ]]
    
    ffxi.ability_recasts = T{}
    ffxi.spell_recasts = T{}

        
    for i,v in pairs(windower.ffxi.get_spell_recasts()) do
        ffxi.spell_recasts[i] = os.clock() + v
    end
        
    for i,v in pairs(windower.ffxi.get_ability_recasts()) do
        ffxi.spell_recasts[i] = os.clock() + v
    end
    
    --[[
            Misc. functions
    ]]
    
    ffxi.locked = function() 
        return ffxi.buffs.costume or ffxi.buffs.terror or ffxi.buffs.stun or ffxi.buffs.sleep or ffxi.buffs.petrification or ffxi.buffs.charm or ffxi.player.hpp == 0 or ffxi.player.status == 4
    end
    ffxi.magiclocked = function()
        return ffxi.buffs.silence or ffxi.buffs.mute or false
    end
    ffxi.jawslocked = function()
        return ffxi.buffs.amnesia or false
    end
    ffxi.itemlocked = function()
        return ffxi.buffs.muddle or false
    end
    ffxi.get_target = function()
        return ffxi.player.target_index ~= 0 and ffxi.mob_array[ffxi.player.target_index] or nil
    end
    ffxi.get_bt = function()
		return windower.ffxi.get_mob_by_target('bt') or false
	end
    ffxi.get_pet = function()
        return ffxi.pet_index ~= 0 and ffxi.mob_array[ffxi.pet_index] or nil
    end
    ffxi.get_time = function()
        return (((os.time() + 91270800) * 25) / (60*60)) % 24
    end
    ffxi.update_currencies = function()
        packets.inject(packets.new('outgoing', 0x010F))
        packets.inject(packets.new('outgoing', 0x0115))
    end
    ffxi.register_buff_event = function(cb)
        ffxi.buff_event_handlers:push(cb);
        return true
    end

    ffxi.add_marker = function(pos)
        -- TODO: is this even possible?
    end
    
    
    --[[
            Grab packet info.
    ]]
        
    for id in L{0x00B,0x00A,0x01C,0x037,0x057,0x061,0x062,0xC8,0xDF,0x076,0x111,0x113,0x118}:it() do
        local p = windower.packets.last_incoming(id)
        if p then _ffxi.inc_packet_parser(id,p) end
    end   
    
    windower.register_event('incoming chunk', _ffxi.inc_packet_parser)
    windower.register_event('outgoing chunk', _ffxi.out_packet_parser)
end
