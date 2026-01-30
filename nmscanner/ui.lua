-- UI Display for NM Scanner
-- Handles rendering the NM notification window with enhanced visual styling

require('luau')
local texts = require('texts')

local ui = {}
ui.display = nil
ui.is_visible = false
ui.current_nm = nil
ui.pulse_phase = 0
ui.display_time = 0  -- Track when NM was first displayed

-- UI Settings
local settings = {
    pos = {
        x = -1,  -- -1 means auto-center
        y = 10
    },
    bg = {
        alpha = 0,
        red = 0,
        green = 0,
        blue = 0,
        visible = false
    },
    padding = 8,
    flags = {
        bold = true,
        draggable = true,
        right = false,
        bottom = false
    },
    text = {
        size = 11,
        font = 'Consolas',
        alpha = 255,
        red = 255,
        green = 255,
        blue = 255,
        stroke = {
            width = 2,
            alpha = 200,
            red = 0,
            green = 0,
            blue = 0
        }
    }
}

-- Color schemes for different NM families
local family_colors = {
    Dragon = {r=255, g=80, b=80},      -- Red
    Wyrm = {r=255, g=120, b=50},       -- Orange
    Demon = {r=180, g=50, b=255},      -- Purple
    Behemoth = {r=139, g=90, b=43},    -- Brown
    Adamantoise = {r=100, g=200, b=100}, -- Green
    Skeleton = {r=200, g=200, b=200},  -- Gray
    Kirin = {r=255, g=215, b=0},       -- Gold
    Avatar = {r=100, g=200, b=255},    -- Blue
    Jailer = {r=150, g=0, b=150},      -- Dark Purple
    default = {r=255, g=100, b=100}    -- Default Red
}

-- Get color for NM family
local function get_family_color(family)
    return family_colors[family] or family_colors.default
end

-- Rank indicators based on level
local function get_rank_symbol(level)
    if level >= 99 then return "★★★ ULTIMATE"
    elseif level >= 85 then return "★★ ELITE"
    elseif level >= 70 then return "★ DANGEROUS"
    else return "⚔ NOTORIOUS" end
end

-- Distance color coding
local function get_distance_color(distance)
    if distance < 10 then return {r=255, g=50, b=50}    -- Close: Red
    elseif distance < 25 then return {r=255, g=200, b=50} -- Medium: Yellow
    else return {r=100, g=200, b=255} end                -- Far: Blue
end

-- Initialize the display
function ui.initialize()
    settings.text.stroke_width = settings.text.stroke.width
    settings.text.stroke_alpha = settings.text.stroke.alpha
    settings.text.stroke_color = settings.text.stroke.red
    settings.text.stroke_color_red = settings.text.stroke.red
    settings.text.stroke_color_green = settings.text.stroke.green
    settings.text.stroke_color_blue = settings.text.stroke.blue
    
    ui.display = texts.new('', settings)
    ui.display:hide()
end

-- Show NM notification with enhanced formatting
function ui.show_nm(nm_data)
    if not nm_data then return end
    
    ui.current_nm = nm_data
    ui.pulse_phase = 0
    
    -- Get colors based on NM properties
    local family_color = get_family_color(nm_data.family)
    local distance_color = get_distance_color(nm_data.distance or 50)
    
    -- Build fancy header with border
    local header = string.format(
        '\\cs(255,50,50)╔═══════════════════════════════════════════╗\\cr\n' ..
        '\\cs(255,50,50)║\\cs(255,255,100)        NOTORIOUS MONSTER DETECTED         \\cs(255,50,50)║\\cr\n' ..
        '\\cs(255,50,50)╠═══════════════════════════════════════════╣\\cr\n'
    )
    
    -- Build NM name
    local nm_name = '\\cs(255,50,50)║\\cr' ..
        '%2s':format(' ') ..
        '\\cs(%d,%d,%d)%-30s\\cr':format(family_color.r, family_color.g, family_color.b, nm_data.name or 'Unknown') ..
        '%11s\\cs(255,50,50)║\\cr\n':format(' ')
    
    -- Build stats section with fixed-width formatting
    local level_line = '\\cs(255,50,50)║\\cr' ..
        '%2s':format(' ') ..
        ('\\cs(200,200,200)%-12s\\cs(255,255,150)%-28s\\cr'):format('Level:', nm_data.level or '??') ..
        '%1s\\cs(255,50,50)║\\cr\n':format(' ')
    
    local distance_line = '\\cs(255,50,50)║\\cr' ..
        '%2s':format(' ') ..
        ('\\cs(200,200,200)%-12s\\cs(%d,%d,%d)%-28s\\cr'):format(
            'Distance:', distance_color.r, distance_color.g, distance_color.b, ('%.1f yalms'):format(nm_data.distance or 0)
        ) ..
        '%1s\\cs(255,50,50)║\\cr':format(' ')
    
    local stats = level_line .. distance_line
    
    -- Add HP if available
    local hp_bar = ''
    if nm_data.hpp and nm_data.hpp > 0 then
        local hp_percent = nm_data.hpp
        
        local hp_color = {r=100, g=255, b=100}
        if hp_percent < 25 then hp_color = {r=255, g=50, b=50}
        elseif hp_percent < 50 then hp_color = {r=255, g=200, b=50} end
        
        hp_bar = '\n\\cs(255,50,50)║\\cr  %s\\cr':format(
            ('\\cs(200,200,200)%-12s\\cs(%d,%d,%d)%d%%'):format(
                'HP:', hp_color.r, hp_color.g, hp_color.b, hp_percent
            )
        ) ..
        '%25s\\cs(255,50,50)║\\cr':format(' ')
    end
    
    -- Build footer
    local footer = string.format(
        '\n\\cs(255,50,50)╠═══════════════════════════════════════════╣\\cr\n' ..
        '\\cs(255,50,50)║\\cr  \\cs(150,150,150)Right-click to dismiss • Auto-hide (30s)\\cr \\cs(255,50,50)║\\cr\n' ..
        '\\cs(255,50,50)╚═══════════════════════════════════════════╝\\cr'
    )
    
    -- Combine all parts
    local display_text = header .. nm_name .. stats .. hp_bar .. footer
    
    ui.display:text(display_text)
    
    -- Auto-center if position is -1
    if settings.pos.x == -1 then
        local windower_settings = windower.get_windower_settings()
        local screen_width = windower_settings.ui_x_res
        ui.display:pos(screen_width / 2 - 200, settings.pos.y)
    end
    
    ui.display:show()
    ui.is_visible = true
    ui.display_time = os.clock()  -- Record when we started displaying
end

-- Update NM data (called continuously while NM is in range)
function ui.update_nm(nm_data)
    if not nm_data then return end
    
    -- If this is a new NM, show it
    if not ui.is_visible or not ui.current_nm or ui.current_nm.mob_id ~= nm_data.mob_id then
        ui.show_nm(nm_data)
        return
    end
    
    print("foo")
    -- Update current NM data and refresh display
    ui.current_nm = nm_data
    ui.show_nm(nm_data)
end

-- Hide the display
function ui.hide()
    if ui.display then
        ui.display:hide()
        ui.is_visible = false
        ui.current_nm = nil
    end
end

-- Update display position
function ui.set_position(x, y)
    settings.pos.x = x
    settings.pos.y = y
    if ui.display then
        ui.display:pos(x, y)
    end
end

-- Get current display position
function ui.get_position()
    if ui.display then
        return {x = ui.display:pos_x(), y = ui.display:pos_y()}
    end
    return {x = settings.pos.x, y = settings.pos.y}
end

-- Update for auto-hide timer
function ui.update()
    if not ui.is_visible or not ui.display then return end
    
    -- Check if 30 seconds have passed since display
    local current_time = os.clock()
    if current_time - ui.display_time >= 30 then
        ui.hide()
        return
    end
    
    -- Check if position has changed (dragged)
    if ui.display then
        local current_x = ui.display:pos_x()
        local current_y = ui.display:pos_y()
        
    else
        if ui.current_nm then
            ui.show_nm(ui.current_nm)
        end
    end
end

-- Get custom theme colors based on time of day or zone
function ui.set_theme(theme)
    if theme == 'dark' then
        settings.bg.red = 10
        settings.bg.green = 0
        settings.bg.blue = 0
    elseif theme == 'blue' then
        settings.bg.red = 0
        settings.bg.green = 0
        settings.bg.blue = 30
    elseif theme == 'purple' then
        settings.bg.red = 20
        settings.bg.green = 0
        settings.bg.blue = 20
    else -- default red
        settings.bg.red = 20
        settings.bg.green = 0
        settings.bg.blue = 0
    end
    
    if ui.display then
        ui.display:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue)
    end
end

-- Check if currently showing
function ui.is_showing()
    return ui.is_visible
end

-- Cleanup
function ui.destroy()
    if ui.display then
        ui.display:destroy()
        ui.display = nil
    end
    ui.is_visible = false
    ui.current_nm = nil
end

return ui
