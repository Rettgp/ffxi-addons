-- Bar module - Individual damage bar UI element
-- Encapsulates the visual elements for a single player's damage bar

local texts = require('texts')
local images = require('images')
local Jobs = require('jobs')

-- Default dimensions (can be overridden)
local DEFAULT_BAR_HEIGHT = 20
local DEFAULT_BAR_WIDTH = 275
local DEFAULT_ICON_SIZE = 18

-- Animation settings
local ANIMATION_SPEED = 8  -- Higher = faster animation (units per second multiplier)

local Bar = {}
Bar.__index = Bar

-- Create a new bar instance
function Bar.new(options)
    options = options or {}
    
    local self = setmetatable({}, Bar)
    
    -- Store dimensions
    self.bar_width = options.bar_width or DEFAULT_BAR_WIDTH
    self.bar_height = options.bar_height or DEFAULT_BAR_HEIGHT
    self.icon_size = options.icon_size or DEFAULT_ICON_SIZE
    
    -- Position tracking
    self.x = 0
    self.y = 0
    
    -- State
    self.visible = false
    self.player_name = nil
    self.job = nil
    
    -- Animation state
    self.current_width = 1
    self.target_width = 1
    
    -- Create UI elements
    self:_create_elements()
    
    return self
end

-- Create all UI elements for the bar
function Bar:_create_elements()
    -- Background bar (dark backdrop)
    self.bg = images.new()
    self.bg:alpha(200)
    self.bg:color(35, 35, 40)
    self.bg:size(self.bar_width, self.bar_height)
    self.bg:draggable(false)
    
    -- Foreground bar (colored progress bar)
    self.fg = images.new()
    self.fg:alpha(220)
    self.fg:size(1, self.bar_height)
    self.fg:draggable(false)
    
    -- Job icon
    self.icon = images.new()
    self.icon:path(windower.addon_path .. 'jobIcons/war.png')
    self.icon:repeat_xy(1, 1)
    self.icon:draggable(false)
    self.icon:fit(false)
    self.icon:alpha(255)
    self.icon:size(self.icon_size, self.icon_size)
    
    -- Name text (left side)
    self.name_text = texts.new()
    self.name_text:font('Consolas', 'Courier New', 'monospace')
    self.name_text:size(9)
    self.name_text:color(255, 255, 255)
    self.name_text:bg_alpha(0)
    self.name_text:bg_visible(false)
    self.name_text:stroke_width(1)
    self.name_text:stroke_color(0, 0, 0)
    self.name_text:stroke_alpha(200)
    self.name_text:draggable(false)
    
    -- Stats text (right side)
    self.stats_text = texts.new()
    self.stats_text:font('Consolas', 'Courier New', 'monospace')
    self.stats_text:size(9)
    self.stats_text:color(255, 255, 255)
    self.stats_text:bg_alpha(0)
    self.stats_text:bg_visible(false)
    self.stats_text:stroke_width(1)
    self.stats_text:stroke_color(0, 0, 0)
    self.stats_text:stroke_alpha(200)
    self.stats_text:draggable(false)
end

-- Position all elements relative to a base position
-- icon_x, icon_y is where the icon goes; bar starts after icon
function Bar:set_position(icon_x, row_y)
    self.x = icon_x
    self.y = row_y
    
    local bar_x = icon_x + self.icon_size + 2
    
    self.icon:pos(icon_x + 1, row_y + 1)
    self.bg:pos(bar_x, row_y)
    self.fg:pos(bar_x, row_y)
    self.name_text:pos(bar_x + 4, row_y + 2)
    self.stats_text:pos(bar_x + self.bar_width - 4, row_y + 2)
end

-- Update bar with player damage data
function Bar:set_damage_data(player_name, damage, max_damage, total_damage, dps, job)
    self.player_name = player_name
    self.job = job
    
    -- Calculate bar width ratio
    local bar_ratio = 1
    if max_damage > 0 then
        bar_ratio = damage / max_damage
    end
    local bar_width = math.max(1, math.floor(self.bar_width * bar_ratio))
    
    -- Set target width for animation (instead of instant update)
    self.target_width = bar_width
    
    -- Calculate percentage
    local percent = 0
    if total_damage > 0 then
        percent = 100 * damage / total_damage
    end
    
    -- Get job color and icon
    local color = Jobs.get_color(job)
    local icon_path = self:_get_icon_path(job)
    
    -- Update foreground bar color (width handled by animate())
    self.fg:color(color[1], color[2], color[3])
    
    -- Update icon
    self.icon:path(icon_path)
    self.icon:size(self.icon_size, self.icon_size)
    
    -- Update name (truncate if needed)
    local display_name = self:_truncate_name(player_name, 12)
    self.name_text:text(display_name)
    
    -- Update stats
    local stats_str = '%s (%s, %.1f%%)':format(
        self:_format_number(damage),
        dps,
        percent
    )
    self.stats_text:text(stats_str)
    self.stats_text:right_justified(true)
    
    -- Show all elements
    self:show_full()
end

-- Show bar with just player name/icon (no damage yet)
function Bar:set_player_only(player_name, job)
    self.player_name = player_name
    self.job = job
    
    local color = Jobs.get_color(job)
    local icon_path = self:_get_icon_path(job)
    
    -- Update icon
    self.icon:path(icon_path)
    self.icon:size(self.icon_size, self.icon_size)
    
    -- Set bar color, reset width instantly (no damage to show)
    self.fg:color(color[1], color[2], color[3])
    self.current_width = 1
    self.target_width = 1
    self.fg:size(1, self.bar_height)
    
    -- Update name
    local display_name = self:_truncate_name(player_name, 12)
    self.name_text:text(display_name)
    self.stats_text:text('')
    
    -- Show name/icon only
    self:show_waiting()
end

-- Clear the bar (empty slot)
function Bar:clear()
    self.player_name = nil
    self.job = nil
    
    -- Reset width instantly when clearing
    self.current_width = 1
    self.target_width = 1
    self.fg:size(1, self.bar_height)
    self.name_text:text('')
    self.stats_text:text('')
    
    self:show_empty()
end

-- Animate bar width toward target
-- Call this on each prerender frame
-- Returns true if animation is still in progress
function Bar:animate()
    if self.current_width == self.target_width then
        return false
    end
    
    local delta = self.target_width - self.current_width
    local step = delta * ANIMATION_SPEED * 0.016  -- ~60fps assumption
    
    -- Ensure minimum step size to avoid getting stuck
    if math.abs(step) < 0.5 then
        step = delta > 0 and 0.5 or -0.5
    end
    
    -- Apply step
    self.current_width = self.current_width + step
    
    -- Snap to target if close enough
    if math.abs(self.target_width - self.current_width) < 1 then
        self.current_width = self.target_width
    end
    
    -- Update visual
    local display_width = math.max(1, math.floor(self.current_width))
    self.fg:size(display_width, self.bar_height)
    
    return self.current_width ~= self.target_width
end

-- Show with full damage display
function Bar:show_full()
    self.visible = true
    self.bg:show()
    self.fg:show()
    self.icon:show()
    self.name_text:show()
    self.stats_text:show()
end

-- Show with just player info (waiting for damage)
function Bar:show_waiting()
    self.visible = true
    self.bg:show()
    self.fg:hide()
    self.icon:show()
    self.name_text:show()
    self.stats_text:hide()
end

-- Show empty (just background)
function Bar:show_empty()
    self.visible = true
    self.bg:show()
    self.fg:hide()
    self.icon:hide()
    self.name_text:hide()
    self.stats_text:hide()
end

-- Show only background (for visibility toggle)
function Bar:show_bg_only()
    self.visible = true
    self.bg:show()
end

-- Hide all elements
function Bar:hide()
    self.visible = false
    self.bg:hide()
    self.fg:hide()
    self.icon:hide()
    self.name_text:hide()
    self.stats_text:hide()
end

-- Get icon path for a job
function Bar:_get_icon_path(job)
    if job then
        return windower.addon_path .. 'jobIcons/' .. job .. '.png'
    end
    return windower.addon_path .. 'jobIcons/war.png'
end

-- Truncate name to max length
function Bar:_truncate_name(name, max_len)
    if not name then return '' end
    if #name > max_len then
        return name:sub(1, max_len - 2) .. '..'
    end
    return name
end

-- Format large numbers (K, M)
function Bar:_format_number(num)
    if num >= 1000000 then
        return string.format('%.2fM', num / 1000000)
    elseif num >= 1000 then
        return string.format('%.1fK', num / 1000)
    else
        return string.format('%.0f', num)
    end
end

return Bar
