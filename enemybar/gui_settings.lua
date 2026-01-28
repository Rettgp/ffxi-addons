--[[
Copyright © 2015, Mike McKee
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of enemybar nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Mike McKee BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

local packets = require('packets')

targetBarHeight = 14
targetBarWidth = 330
subtargetBarHeight = 12
subtargetBarWidth = 198
visible = false

bg_cap_path = windower.addon_path.. 'bg_cap.png'
bg_body_path = windower.addon_path.. 'bg_body.png'
fg_body_path = windower.addon_path.. 'fg_body.png'

center_screen = windower.get_windower_settings().ui_x_res / 2

text_settings = {}
text_settings.pos = {}
text_settings.pos.x = center_screen
text_settings.pos.y = 50
text_settings.text = {}
text_settings.text.size = 14
text_settings.text.font = 'Arial'
text_settings.text.fonts = {'Arial'}
text_settings.text.stroke = {}
text_settings.text.stroke.width = 2
text_settings.text.stroke.alpha = 127
text_settings.text.stroke.red = 50
text_settings.text.stroke.green = 50
text_settings.text.stroke.blue = 50 
text_settings.flags = {}
text_settings.flags.bold = true
text_settings.flags.draggable = false
text_settings.bg = {}
text_settings.bg.visible = false

lvl_text_settings = {}
lvl_text_settings.pos = {}
lvl_text_settings.pos.x = center_screen
lvl_text_settings.pos.y = 50
lvl_text_settings.text = {}
lvl_text_settings.text.size = 8
lvl_text_settings.text.font = 'Arial'
lvl_text_settings.text.fonts = {'Arial'}
lvl_text_settings.text.stroke = {}
lvl_text_settings.text.stroke.width = 2
lvl_text_settings.text.stroke.alpha = 127
lvl_text_settings.text.stroke.red = 100
lvl_text_settings.text.stroke.green = 100
lvl_text_settings.text.stroke.blue = 100 
lvl_text_settings.flags = {}
lvl_text_settings.flags.bold = true
lvl_text_settings.flags.draggable = false
lvl_text_settings.bg = {}
lvl_text_settings.bg.visible = false

diff_text_settings = {}
diff_text_settings.pos = {}
diff_text_settings.pos.x = center_screen - 25
diff_text_settings.pos.y = 50
diff_text_settings.text = {}
diff_text_settings.text.size = 12
diff_text_settings.text.font = 'Arial'
diff_text_settings.text.fonts = {'Arial'}
diff_text_settings.text.stroke = {}
diff_text_settings.text.stroke.width = 2
diff_text_settings.text.stroke.alpha = 127
diff_text_settings.text.stroke.red = 50
diff_text_settings.text.stroke.green = 50
diff_text_settings.text.stroke.blue = 50 
diff_text_settings.flags = {}
diff_text_settings.flags.bold = true
diff_text_settings.flags.draggable = false
diff_text_settings.bg = {}
diff_text_settings.bg.visible = false

tbg_cap_settings = {}
tbg_cap_settings.pos = {}
tbg_cap_settings.pos.x = center_screen
tbg_cap_settings.pos.y = 50
tbg_cap_settings.visible = true
tbg_cap_settings.color = {}
tbg_cap_settings.color.alpha = 255
tbg_cap_settings.color.red = 150
tbg_cap_settings.color.green = 0
tbg_cap_settings.color.blue = 0
tbg_cap_settings.size = {}
tbg_cap_settings.size.width = 1
tbg_cap_settings.size.height = 598
tbg_cap_settings.texture = {}
tbg_cap_settings.texture.path = bg_cap_path
tbg_cap_settings.texture.fit = true
tbg_cap_settings.repeatable = {}
tbg_cap_settings.repeatable.x = 1
tbg_cap_settings.repeatable.y = 1
tbg_cap_settings.draggable = false

stbg_cap_settings = {}
stbg_cap_settings.pos = {}
stbg_cap_settings.pos.x = center_screen
stbg_cap_settings.pos.y = 50
stbg_cap_settings.visible = true
stbg_cap_settings.color = {}
stbg_cap_settings.color.alpha = 255
stbg_cap_settings.color.red = 0
stbg_cap_settings.color.green = 51
stbg_cap_settings.color.blue = 255
stbg_cap_settings.size = {}
stbg_cap_settings.size.width = 1
stbg_cap_settings.size.height = subtargetBarHeight
stbg_cap_settings.texture = {}
stbg_cap_settings.texture.path = bg_cap_path
stbg_cap_settings.texture.fit = true
stbg_cap_settings.repeatable = {}
stbg_cap_settings.repeatable.x = 1
stbg_cap_settings.repeatable.y = 1
stbg_cap_settings.draggable = false

tbg_body_settings = {}
tbg_body_settings.pos = {}
tbg_body_settings.pos.x = center_screen
tbg_body_settings.pos.y = 50
tbg_body_settings.visible = true
tbg_body_settings.color = {}
tbg_body_settings.color.alpha = 255
tbg_body_settings.color.red = 150
tbg_body_settings.color.green = 0
tbg_body_settings.color.blue = 0
tbg_body_settings.size = {}
tbg_body_settings.size.width = targetBarWidth
tbg_body_settings.size.height = targetBarHeight
tbg_body_settings.texture = {}
tbg_body_settings.texture.path = bg_body_path
tbg_body_settings.texture.fit = true
tbg_body_settings.repeatable = {}
tbg_body_settings.repeatable.x = 1
tbg_body_settings.repeatable.y = 1
tbg_body_settings.draggable = false

stbg_body_settings = {}
stbg_body_settings.pos = {}
stbg_body_settings.pos.x = center_screen + 400
stbg_body_settings.pos.y = 65
stbg_body_settings.visible = true
stbg_body_settings.color = {}
stbg_body_settings.color.alpha = 255
stbg_body_settings.color.red = 0
stbg_body_settings.color.green = 51
stbg_body_settings.color.blue = 255
stbg_body_settings.size = {}
stbg_body_settings.size.width = subtargetBarWidth
stbg_body_settings.size.height = subtargetBarHeight
stbg_body_settings.texture = {}
stbg_body_settings.texture.path = bg_body_path
stbg_body_settings.texture.fit = true
stbg_body_settings.repeatable = {}
stbg_body_settings.repeatable.x = 1
stbg_body_settings.repeatable.y = 1
stbg_body_settings.draggable = false

tfgg_body_settings = {}
tfgg_body_settings.pos = {}
tfgg_body_settings.pos.x = center_screen
tfgg_body_settings.pos.y = 50
tfgg_body_settings.visible = true
tfgg_body_settings.color = {}
tfgg_body_settings.color.alpha = 200
tfgg_body_settings.color.red = 255
tfgg_body_settings.color.green = 0
tfgg_body_settings.color.blue = 0
tfgg_body_settings.size = {}
tfgg_body_settings.size.width = targetBarWidth
tfgg_body_settings.size.height = targetBarHeight
tfgg_body_settings.texture = {}
tfgg_body_settings.texture.path = fg_body_path
tfgg_body_settings.texture.fit = true
tfgg_body_settings.repeatable = {}
tfgg_body_settings.repeatable.x = 1
tfgg_body_settings.repeatable.y = 1
tfgg_body_settings.draggable = false

tfg_body_settings = {}
tfg_body_settings.pos = {}
tfg_body_settings.pos.x = center_screen
tfg_body_settings.pos.y = 50
tfg_body_settings.visible = true
tfg_body_settings.color = {}
tfg_body_settings.color.alpha = 255
tfg_body_settings.color.red = 255
tfg_body_settings.color.green = 51
tfg_body_settings.color.blue = 0
tfg_body_settings.size = {}
tfg_body_settings.size.width = targetBarWidth
tfg_body_settings.size.height = targetBarHeight
tfg_body_settings.texture = {}
tfg_body_settings.texture.path = fg_body_path
tfg_body_settings.texture.fit = true
tfg_body_settings.repeatable = {}
tfg_body_settings.repeatable.x = 1
tfg_body_settings.repeatable.y = 1
tfg_body_settings.draggable = false

stfg_body_settings = {}
stfg_body_settings.pos = {}
stfg_body_settings.pos.x = center_screen + 400
stfg_body_settings.pos.y = 65
stfg_body_settings.visible = true
stfg_body_settings.color = {}
stfg_body_settings.color.alpha = 255
stfg_body_settings.color.red = 0
stfg_body_settings.color.green = 102
stfg_body_settings.color.blue = 255
stfg_body_settings.size = {}
stfg_body_settings.size.width = subtargetBarWidth
stfg_body_settings.size.height = subtargetBarHeight
stfg_body_settings.texture = {}
stfg_body_settings.texture.path = fg_body_path
stfg_body_settings.texture.fit = true
stfg_body_settings.repeatable = {}
stfg_body_settings.repeatable.x = 1
stfg_body_settings.repeatable.y = 1
stfg_body_settings.draggable = false

-- Draggable container using images for proper size control
container_settings = {}
container_settings.pos = {}
container_settings.pos.x = center_screen
container_settings.pos.y = 50
container_settings.visible = true
container_settings.color = {}
container_settings.color.alpha = 0
container_settings.color.red = 255
container_settings.color.green = 0
container_settings.color.blue = 255
container_settings.size = {}
container_settings.size.width = targetBarWidth
container_settings.size.height = targetBarHeight
container_settings.draggable = true

defaults = {}
defaults.font = 'Arial'
defaults.font_size = 14
defaults.pos = {}
defaults.pos.x = 400
defaults.pos.y = 50

settings = config.load(defaults)
config.save(settings)

config.register(settings, function(settings_table) 
    --Validating settings.xml values
    local nx = 0
    if settings_table.pos.x == nil or settings_table.pos.x < 0 then
        nx = center_screen
    else
        nx = settings_table.pos.x
    end
    
    -- Create invisible draggable container first
    container_settings.pos.x = nx
    container_settings.pos.y = settings_table.pos.y
    container = images.new(container_settings)
    
    text_settings.pos.x = nx - 5
    text_settings.pos.y = settings_table.pos.y - 20
    text_settings.text.font = settings_table.font
    text_settings.text.size = settings_table.font_size

    lvl_text_settings.pos.x = nx + 15
    lvl_text_settings.pos.y = settings_table.pos.y
    lvl_text_settings.text.font = settings_table.font
    lvl_text_settings.text.size = targetBarHeight - 5

    tbg_cap_settings.pos.x = nx
    tbg_cap_settings.pos.y = settings_table.pos.y
 
    stbg_cap_settings.pos.x = nx
    stbg_cap_settings.pos.y = settings_table.pos.y
   
    tbg_body_settings.pos.x = nx
    tbg_body_settings.pos.y = settings_table.pos.y
 
    stbg_body_settings.pos.x = nx
    stbg_body_settings.pos.y = settings_table.pos.y
  
    tfgg_body_settings.pos.x = nx
    tfgg_body_settings.pos.y = settings_table.pos.y
  
    tfg_body_settings.pos.x = nx
    tfg_body_settings.pos.y = settings_table.pos.y
 
    stfg_body_settings.pos.x = nx
    stfg_body_settings.pos.y = settings_table.pos.y
    
    tbg_cap_l = images.new(tbg_cap_settings)
    tbg_cap_r = images.new(tbg_cap_settings)
    tbg_body = images.new(tbg_body_settings)
    tfgg_body = images.new(tfgg_body_settings)
    tfg_body = images.new(tfg_body_settings)
    t_text = texts.new('  ${name|(Name)} - HP: ${hpp|(100)}% (${distance||%.1f}) ${debug|}', text_settings)

    stbg_cap_l = images.new(stbg_cap_settings)
    stbg_cap_r = images.new(stbg_cap_settings)
    stbg_body = images.new(stbg_body_settings)
    stfg_body = images.new(stfg_body_settings)
    st_text = texts.new(' ${name|(Name)}', text_settings)
    lvl_text = texts.new('Lvl ${lvl|-}   ${difficulty| }', lvl_text_settings)
    
    tbg_cap_l:pos_x(tbg_cap_l:pos_x() - 1)
    tbg_cap_r:pos_x(tbg_cap_r:pos_x() + targetBarWidth + 1)
    
    stbg_cap_l:pos(stbg_cap_l:pos_x() + 399, 65)
    stbg_cap_r:pos(stbg_cap_r:pos_x() + subtargetBarWidth + 1, 65)
    stfg_body:pos(stfg_body:pos_x() + 400, 65)
    stbg_body:pos(stbg_body:pos_x() + 400, 65)
    st_text:pos(st_text:pos_x() + 400, 65)
end)

-- Update all element positions when container is dragged
windower.register_event('prerender', function()
    if container then
        local container_x = container:pos_x()
        local container_y = container:pos_y()
        
        -- Only update if position has changed
        if container_x ~= settings.pos.x or container_y ~= settings.pos.y then
            settings.pos.x = container_x
            settings.pos.y = container_y
            
            -- Update all elements relative to container
            tbg_cap_l:pos(container_x - 1, container_y)
            tbg_cap_r:pos(container_x + targetBarWidth + 1, container_y)
            tbg_body:pos(container_x, container_y)
            tfgg_body:pos(container_x, container_y)
            tfg_body:pos(container_x, container_y)
            t_text:pos(container_x - 5, container_y - 20)
            lvl_text:pos(container_x + 15, container_y)
            
            config.save(settings)
        end
    end
end)

check_claim = function(claim_id)
    if player_id == claim_id then
        return true
    else
        for i = 1, 5, 1 do
            member = windower.ffxi.get_mob_by_target('p'..i)
            if member == nil then
                -- do nothing
            elseif member.id == claim_id then 
                return true
            end
        end
    end
    return false
end

windower.register_event('incoming text',function (original, modified, mode)
    if (mode == 191) then
        -- Try to extract from formatted text (e.g., "level 2 (EP)")
        foo, bar, check_id = string.find(original, ".*%((%u+)%).*")
        local original_clean = original:gsub('%W','')
        foo1, bar1, level = string.find(original_clean, "level%s*(%d+).*")
        
        -- Convert to lowercase for case-insensitive matching
        local original_lower = original:lower()

        if level then
            lvl_text.lvl = level
        else
            lvl_text.lvl = "-"
        end

        -- Handle difficulty from formatted text or default game text
        if check_id then
            lvl_text.difficulty = check_id
        elseif string.find(original_clean, ".*impossible.*") then
            lvl_text.difficulty = "IMPOSSIBLE"
        -- Check for default game difficulty phrases (case-insensitive)
        elseif string.find(original_lower, "too weak") then
            lvl_text.difficulty = "TW"
        elseif string.find(original_lower, "easy prey") then
            lvl_text.difficulty = "EP"
        elseif string.find(original_lower, "decent challenge") then
            lvl_text.difficulty = "DC"
        elseif string.find(original_lower, "even match") then
            lvl_text.difficulty = "EM"
        elseif string.find(original_lower, "tough") and not string.find(original_lower, "very") and not string.find(original_lower, "incredibly") then
            lvl_text.difficulty = "T"
        elseif string.find(original_lower, "very tough") then
            lvl_text.difficulty = "VT"
        elseif string.find(original_lower, "incredibly tough") then
            lvl_text.difficulty = "IT"
        else
            lvl_text.difficulty = nil
        end

        return true
    end
end)

target_change = function(index)
    if index == 0 then
        visible = false
    else
        visible = true
    end
    target = windower.ffxi.get_mob_by_target('t')

    if (target and target.valid_target and target.is_npc) then
        local check_target = packets.new('outgoing', 0x0DD, {
            ['Target'] = target.id,
            ['Target Index'] = target.index,
            ['_unknown1'] = 0,
            ['Check Type'] = 0,
            ['_junk1'] = 0
        })
        lvl_text.lvl = '-'
        lvl_text.difficulty = ' '
        packets.inject(check_target)
    end
end

