-- Display module with WoW Details!-style horizontal bars
local texts = require('texts')
local images = require('images')
local Jobs = require('jobs')
local Bar = require('bar')

-- UI Constants
local VISIBLE_BARS = 6
local BAR_HEIGHT = 20
local BAR_WIDTH = 275
local BAR_SPACING = 1
local ICON_SIZE = 18
local HEADER_HEIGHT = 18

local Display = {
    visible = true,
    settings = nil,
    bars = {},
    initialized = false,
    last_x = 0,
    last_y = 0,
    player_jobs = {}  -- Player name -> job short name cache
}

local function get_total_width()
    return BAR_WIDTH + ICON_SIZE + 4
end

local function get_total_height()
    return HEADER_HEIGHT + (VISIBLE_BARS * (BAR_HEIGHT + BAR_SPACING))
end

function Display:new(settings, db)
    local repr = setmetatable({
        db = db,
        bars = {},
        player_jobs = {},
        initialized = false,
        last_x = 0,
        last_y = 0
    }, self)
    self.__index = self
    repr.settings = settings
    repr.visible = settings.visible
    
    repr:create_elements()
    repr:position_all_elements()
    repr:visibility(repr.visible)
    
    -- Register prerender for dragging and bar animations
    windower.register_event('prerender', function()
        repr:check_drag()
        repr:animate_bars()
    end)
    
    return repr
end

function Display:create_elements()
    -- Main container (draggable)
    self.container = images.new()
    self.container:alpha(220)
    self.container:color(15, 15, 20)
    self.container:size(get_total_width(), get_total_height())
    self.container:draggable(true)
    
    -- Title bar
    self.title_bar = images.new()
    self.title_bar:alpha(255)
    self.title_bar:color(30, 30, 40)
    self.title_bar:size(get_total_width(), HEADER_HEIGHT)
    self.title_bar:draggable(false)
    
    -- Title text
    self.title_text = texts.new()
    self.title_text:font('Consolas', 'Courier New', 'monospace')
    self.title_text:size(9)
    self.title_text:color(200, 200, 200)
    self.title_text:bg_alpha(0)
    self.title_text:bg_visible(false)
    self.title_text:draggable(false)
    
    -- Create bar elements using Bar module
    self.bars = {}
    for i = 1, VISIBLE_BARS do
        self.bars[i] = Bar.new({
            bar_width = BAR_WIDTH,
            bar_height = BAR_HEIGHT,
            icon_size = ICON_SIZE
        })
    end
    
    self.initialized = true
end

function Display:position_all_elements()
    local base_x = self.settings.display.pos.x
    local base_y = self.settings.display.pos.y
    
    -- Position container
    self.container:pos(base_x, base_y)
    
    -- Position title bar and text
    self.title_bar:pos(base_x, base_y)
    self.title_text:pos(base_x + 3, base_y + 2)
    
    -- Position each bar
    for i, bar in ipairs(self.bars) do
        local row_y = base_y + HEADER_HEIGHT + ((i - 1) * (BAR_HEIGHT + BAR_SPACING))
        bar:set_position(base_x, row_y)
    end
    
    self.last_x = base_x
    self.last_y = base_y
end

function Display:check_drag()
    if not self.initialized or not self.container then
        return
    end
    
    local current_x = self.container:pos_x()
    local current_y = self.container:pos_y()
    
    if current_x ~= self.last_x or current_y ~= self.last_y then
        self.settings.display.pos.x = current_x
        self.settings.display.pos.y = current_y
        self:position_all_elements()
        self.settings:save()
    end
end

function Display:animate_bars()
    if not self.initialized then
        return
    end
    
    for _, bar in ipairs(self.bars) do
        bar:animate()
    end
end

function Display:set_position(posx, posy)
    self.settings.display.pos.x = posx
    self.settings.display.pos.y = posy
    self:position_all_elements()
end

function Display:visibility(v)
    self.visible = v
    self.settings.visible = v
    self.settings:save()
    
    if v then
        self:show_all()
    else
        self:hide_all()
    end
end

function Display:show_all()
    self.container:show()
    self.title_bar:show()
    self.title_text:show()
    
    for i, bar in ipairs(self.bars) do
        bar:show_bg_only()
    end
    
    -- Prepopulate with party members
    self:reset()
end

function Display:hide_all()
    self.container:hide()
    self.title_bar:hide()
    self.title_text:hide()
    
    for i, bar in ipairs(self.bars) do
        bar:hide()
    end
end

function Display:debug_party()
    windower.add_to_chat(207, '--- Scoreboard Debug ---')
    
    -- Show party member names as they appear in party
    local party = windower.ffxi.get_party()
    if party then
        windower.add_to_chat(207, 'Party members:')
        local slots = {'p0', 'p1', 'p2', 'p3', 'p4', 'p5'}
        for _, slot in ipairs(slots) do
            local member = party[slot]
            if member and type(member) == 'table' and member.name then
                local trust_job = Jobs.get_trust_job(member.name)
                local in_trust_table = trust_job and 'YES ('..trust_job..')' or 'NO'
                local cached = self.player_jobs[member.name] or 'not cached'
                windower.add_to_chat(207, string.format('  %s: "%s" | trust_table=%s | cached=%s', 
                    slot, member.name, in_trust_table, cached))
            end
        end
    end
    
    windower.add_to_chat(207, 'Job Cache:')
    local count = 0
    for name, job in pairs(self.player_jobs) do
        windower.add_to_chat(207, string.format('  %s: %s', name, job))
        count = count + 1
    end
    
    if count == 0 then
        windower.add_to_chat(207, '  (empty)')
    end
    
    windower.add_to_chat(207, '--- End Debug ---')
end

function Display:report_filters()
    local mob_str
    local filters = self.db:get_filters()

    if filters:empty() then
        mob_str = "Scoreboard filters: None (Displaying damage for all mobs)"
    else
        mob_str = "Scoreboard filters: " .. filters:concat(', ')
    end
    windower.add_to_chat(55, mob_str)
end

function Display:get_sorted_player_damage()
    local player_total_dmg = T{}

    if self.db:empty() then
        return {}, 0
    end

    for mob, players in self.db:iter() do
        for player_name, player in pairs(players) do
            if player_total_dmg[player_name] then
                player_total_dmg[player_name] = player_total_dmg[player_name] + player.damage
            else
                player_total_dmg[player_name] = player.damage
            end
        end
    end

    local sortable = T{}
    local total_damage = 0
    for player, damage in pairs(player_total_dmg) do
        total_damage = total_damage + damage
        sortable:append({player, damage})
    end

    table.sort(sortable, function(a, b)
        return a[2] > b[2]
    end)

    return sortable, total_damage
end

function Display:update_player_jobs()
    -- Get player's own job
    local player = windower.ffxi.get_player()
    if player then
        if player.main_job_id and player.main_job_id > 0 then
            local job_short = Jobs.get_short_name(player.main_job_id)
            if job_short then
                self.player_jobs[player.name] = job_short
            end
        elseif player.main_job then
            self.player_jobs[player.name] = player.main_job:lower()
        end
    end
    
    -- Get party members and check for trusts
    local party = windower.ffxi.get_party()
    if party then
        local slots = {'p0', 'p1', 'p2', 'p3', 'p4', 'p5'}
        for _, slot in ipairs(slots) do
            local member = party[slot]
            if member and type(member) == 'table' and member.name then
                -- Skip if already have job for this member
                if not self.player_jobs[member.name] then
                    -- Check if it's a trust
                    local trust_job = Jobs.get_trust_job(member.name)
                    if trust_job then
                        self.player_jobs[member.name] = trust_job
                    end
                end
            end
        end
    end
end

-- Set a player's job manually (called from packet handler)
function Display:set_player_job(player_name, job)
    if player_name and job then
        self.player_jobs[player_name] = job:lower()
    end
end

function Display:build_header_text()
    local dps_status
    if dps_clock:is_active() then
        dps_status = 'Active'
    else
        dps_status = 'Paused'
    end
    
    local dps_clock_str = ''
    if dps_clock:is_active() or dps_clock.clock > 1 then
        dps_clock_str = ' (%s)':format(dps_clock:to_string())
    end
    
    return 'Damage Done - %s%s':format(dps_status, dps_clock_str)
end

function Display:update()
    if not self.visible then
        return
    end

    if not self.initialized then
        return
    end

    self:update_player_jobs()
    self.title_text:text(self:build_header_text())

    if self.db:empty() then
        self:reset()
        return
    end

    local damage_table, total_damage = self:get_sorted_player_damage()
    local party_members = self:get_party_members()
    
    -- Build a set of players who have damage
    local players_with_damage = {}
    for _, entry in ipairs(damage_table) do
        players_with_damage[entry[1]] = true
    end
    
    -- Get party members without damage to fill remaining slots
    local party_without_damage = {}
    for _, name in ipairs(party_members) do
        if not players_with_damage[name] then
            table.insert(party_without_damage, name)
        end
    end
    
    local max_damage = 0
    if #damage_table > 0 then
        max_damage = damage_table[1][2]
    end

    for i = 1, VISIBLE_BARS do
        local bar = self.bars[i]
        
        if damage_table[i] then
            -- Player has damage data
            local player_name = damage_table[i][1]
            local damage = damage_table[i][2]
            local job = self.player_jobs[player_name]
            
            local dps
            if dps_clock.clock == 0 then
                dps = "N/A"
            else
                dps = '%.1f':format(damage / dps_clock.clock)
            end
            
            bar:set_damage_data(player_name, damage, max_damage, total_damage, dps, job)
        else
            -- No damage data for this slot - show party member without damage if available
            local slot_index = i - #damage_table
            if party_without_damage[slot_index] then
                local player_name = party_without_damage[slot_index]
                local job = self.player_jobs[player_name]
                bar:set_player_only(player_name, job)
            else
                -- Empty slot
                bar:clear()
            end
        end
    end
end

function Display:get_party_members()
    local party = windower.ffxi.get_party()
    if not party then return {} end
    
    local members = {}
    local slots = {'p0', 'p1', 'p2', 'p3', 'p4', 'p5'}
    
    for _, slot in ipairs(slots) do
        local member = party[slot]
        if member and type(member) == 'table' and member.name then
            table.insert(members, member.name)
        end
    end
    
    return members
end

function Display:reset()
    self.title_text:text('Damage Done - Waiting...')
    
    -- Update player jobs first
    self:update_player_jobs()
    
    -- Get party members to prepopulate
    local party_members = self:get_party_members()
    
    for i, bar in ipairs(self.bars) do
        if party_members[i] then
            local player_name = party_members[i]
            local job = self.player_jobs[player_name]
            bar:set_player_only(player_name, job)
        else
            bar:clear()
        end
    end
end

--------------------------------------------------------------------
-- Report functions (kept for compatibility)
--------------------------------------------------------------------

local function build_input_command(chatmode, tell_target)
    local input_cmd = 'input '
    if chatmode then
        input_cmd = input_cmd .. '/' .. chatmode .. ' '
        if tell_target then
            input_cmd = input_cmd .. tell_target .. ' '
        end
    end
    return input_cmd
end

local function wrap_elements(elements, header, alt, sep)
    local max_line_length = 120
    if not sep then
        sep = ', '
    end

    local lines = T{}
    local current_line = nil
    local line_length

    local i = 1
    if not alt then
        while i <= #elements do
            if not current_line then
                current_line = T{}
                line_length = header:len()
                lines:append(current_line)
            end

            local new_line_length = line_length + elements[i]:len() + sep:len()
            if new_line_length > max_line_length then
                current_line = T{}
                lines:append(current_line)
                new_line_length = elements[i]:len() + sep:len()
            end

            current_line:append(elements[i])
            line_length = new_line_length
            i = i + 1
        end
        local baked_lines = lines:map(function (ls) return ls:concat(sep) end)
        if header:len() > 0 and #baked_lines > 0 then
            baked_lines[1] = header .. baked_lines[1]
        end
        return baked_lines
    else
        local header_line = T{}
        header_line:append(header)
        lines:append(header_line)
        while i <= #elements do
            current_line = T{}
            lines:append(current_line)
            current_line:append(elements[i])
            i = i + 1
        end
        local baked_lines = lines:map(function (ls) return ls:concat(' ') end)
        return baked_lines
    end
end

local function slow_output(chatprefix, lines, limit)
    windower.send_command(lines:map(function (l) return chatprefix .. l end):concat('; wait 1.2 ; '))
end

function Display:report_summary(...)
    local chatmode, tell_target = table.unpack({...})

    local damage_table, total_damage = self:get_sorted_player_damage()

    local elements = T{}
    for k, v in pairs(damage_table) do
        elements:append('%s %.0f(%.1f%%)':format(v[1], v[2], 100 * v[2]/total_damage))
    end

    slow_output(build_input_command(chatmode, tell_target),
                wrap_elements(elements, 'Damage: ', self.settings.oneperline),
                self.settings.numplayers)
end

Display.stat_summaries = {}

Display.stat_summaries._format_title = function (msg)
    local line_length = 40
    local msg_length  = msg:len()
    local border_len = math.floor(line_length / 2 - msg_length / 2)
    return ' ':rep(border_len) .. msg .. ' ':rep(border_len)
end

Display.stat_summaries['range'] = function (stats, filters, options)
    local lines = T{}
    for name, pair in pairs(stats) do
        lines:append('%-20s %d min   %d max':format(name, pair[1], pair[2]))
    end

    if #lines > 0 and options and options.name then
        sb_output(Display.stat_summaries._format_title('-= '..options.name..' (' .. filters .. ') =-'))
        sb_output(lines)
    end
end

Display.stat_summaries['average'] = function (stats, filters, options)
    local lines = T{}
    for name, pair in pairs(stats) do
        if options and options.percent then
            lines:append('%-20s %.2f%% (%d sample%s)':format(name, 100 * pair[1], pair[2],
                                                                  pair[2] == 1 and '' or 's'))
        else
            lines:append('%-20s %d (%ds)':format(name, pair[1], pair[2]))
        end
    end

    if #lines > 0 and options and options.name then
        sb_output(Display.stat_summaries._format_title('-= '..options.name..' (' .. filters .. ') =-'))
        sb_output(lines)
    end
end

Display.show_stat = function()
    return function (self, stat, player_filter)
        local stats = self.db:query_stat(stat, player_filter)
        local filters = self.db:get_filters()
        local filter_str

        if filters:empty() then
            filter_str = 'All mobs'
        else
            filter_str = filters:concat(', ')
        end
        
        Display.stat_summaries[Display.stat_summaries._all_stats[stat].category](stats, filter_str, Display.stat_summaries._all_stats[stat])
    end
end()

Display.stat_summaries._all_stats = T{
    ['acc']        = {percent=true,  category="average", name='Accuracy'},
    ['racc']       = {percent=true,  category="average", name='Ranged Accuracy'},
    ['crit']       = {percent=true,  category="average", name='Melee Crit. Rate'},
    ['rcrit']      = {percent=true,  category="average", name='Ranged Crit. Rate'},
    ['wsavg']      = {percent=false, category="average", name='WS Average'}, 
    ['wsacc']      = {percent=true,  category="average", name='WS Accuracy'}, 
    ['mavg']       = {percent=false, category="average", name='Melee Non-Crit. Avg. Damage'},
    ['mrange']     = {percent=false, category="range",   name='Melee Non-Crit. Range'},
    ['critavg']    = {percent=false, category="average", name='Melee Crit. Avg. Damage'},
    ['critrange']  = {percent=false, category="range",   name='Melee Crit. Range'},
    ['ravg']       = {percent=false, category="average", name='Ranged Non-Crit. Avg. Damage'},
    ['rrange']     = {percent=false, category="range",   name='Ranged Non-Crit. Range'},
    ['rcritavg']   = {percent=false, category="average", name='Ranged Crit. Avg. Damage'},
    ['rcritrange'] = {percent=false, category="range",   name='Ranged Crit. Range'},
}

function Display:report_stat(stat, args)
    if Display.stat_summaries._all_stats:containskey(stat) then
        local stats = self.db:query_stat(stat, args.player)

        local elements = T{}
        local header   = Display.stat_summaries._all_stats[stat].name .. ': '
        for name, stat_pair in pairs(stats) do
            if stat_pair[2] > 0 then
                if Display.stat_summaries._all_stats[stat].category == 'range' then
                    elements:append({stat_pair[1], ('%s %d~%d'):format(name, stat_pair[1], stat_pair[2])})
                elseif Display.stat_summaries._all_stats[stat].percent then
                    elements:append({stat_pair[1], ('%s %.2f%% (%ds)'):format(name, stat_pair[1] * 100, stat_pair[2])})
                else
                    elements:append({stat_pair[1], ('%s %d (%ds)'):format(name, stat_pair[1], stat_pair[2])})
                end
            end
        end
        table.sort(elements, function(a, b)
            return a[1] > b[1]
        end)

        local wrapped = wrap_elements(elements:slice(1, self.settings.numplayers):map(function (p) return p[2] end), header, self.settings.oneperline)
        slow_output(build_input_command(args.chatmode, args.telltarget), wrapped, self.settings.numplayers)
    end
end

return Display
