icon_lib = require('lib/icon')
texts = require('texts')

local move_boxes = {}
move_boxes.theme = {}

local box_config = {
	count = 0,
	rows = {},
	icons = {},
	sub_config = {},
	drag_handles = {} -- text elements for dragging bars
}

local icon_height = 40
local scaled_icon_height = 0
local icon_width = 40
local scaled_icon_width = 0
local vert_cols = 2
local debug = false

local images_setup = {
	draggable = false,
	size = {
		width  = 10,
		height = 100
	},
	pos = {
		x = 100,
		y = 100
	},
	texture = {
		fit = false
	},
	visible = true,
}

local drag_handle_setup = {
	flags = {
		draggable = false
	}
}

local private_boxes = {
	pos = {
		x = 0,
		y = 0
	},
	size = {
		x = 0,
		y = 0
	}
}


local function compute_size(box, sub_conf, is_vertical)
	if (is_vertical == true) then
		local t_width   = 2 * (scaled_icon_width + move_boxes.theme.slot_spacing) - move_boxes.theme.slot_spacing
		local t_height  = (scaled_icon_height + move_boxes.theme.slot_spacing) * (move_boxes.theme.columns / 2) -
		move_boxes.theme.slot_spacing
		sub_conf.width  = t_width
		sub_conf.height = t_height
		box:size(t_width, t_height)
	else
		local t_height  = (scaled_icon_height + move_boxes.theme.slot_spacing) - move_boxes.theme.slot_spacing
		local t_width   = (scaled_icon_width + move_boxes.theme.slot_spacing) * move_boxes.theme.columns -
		move_boxes.theme.slot_spacing
		sub_conf.width  = t_width
		sub_conf.height = t_height
		box:size(t_width, t_height)
	end
end

-- Get the position for the drag handle (left side of bar)
local function get_drag_handle_pos(theme, row_index)
	local offset = theme.offsets[tostring(row_index)]
	local handle_x, handle_y

	if offset.Vertical == true then
		-- For vertical bars, place handle above the bar
		handle_x = offset.OffsetX
		handle_y = offset.OffsetY - 20
	else
		-- For horizontal bars, place handle to the left of the bar
		handle_x = offset.OffsetX - 45
		handle_y = offset.OffsetY + (scaled_icon_height / 2) - 8
	end

	return handle_x, handle_y
end

-- Initialize a drag handle for a row
local function init_drag_handle(theme, row_index)
	local handle = texts.new(table.copy(drag_handle_setup, true))
	handle:text('[ ' .. row_index .. ' ]')
	handle:bg_alpha(200)
	handle:bg_color(40, 40, 40)
	handle:bg_visible(true)
	handle:font(theme.font)
	handle:size(theme.font_size)
	handle:color(255, 200, 100)
	handle:stroke_transparency(200)
	handle:stroke_color(0, 0, 0)
	handle:stroke_width(1)

	local x, y = get_drag_handle_pos(theme, row_index)
	handle:pos(x, y)
	handle:hide()

	return handle
end

-- Update slot overlay positions for a row when it moves
local function update_slot_positions(theme, row_index, new_x, new_y)
	for s = 1, theme.columns do
		local slot_x, slot_y
		local is_vertical = theme.offsets[tostring(row_index)].Vertical

		if is_vertical == true then
			if s < math.floor(theme.columns / 2) + 1 then
				slot_x = new_x
				slot_y = new_y + ((scaled_icon_height + theme.slot_spacing) * (s - 1))
			else
				slot_x = new_x + (scaled_icon_width + theme.slot_spacing)
				slot_y = new_y + ((scaled_icon_height + theme.slot_spacing) * (s - math.floor(theme.columns / 2) - 1))
			end
		else
			slot_x = new_x + ((scaled_icon_width + theme.slot_spacing) * (s - 1))
			slot_y = new_y
		end

		box_config.icons[row_index].slot[s]:pos(slot_x, slot_y)
		box_config.icons[row_index].init_slot[s].x = slot_x
		box_config.icons[row_index].init_slot[s].y = slot_y
	end
end

function move_boxes:init_slot(row_index, slot_index)
	slot           = {}
	slot           = images.new(table.copy(images_setup, true))
	local x        = icon_lib:get_slot_x(row_index, slot_index)
	local y        = icon_lib:get_slot_y(row_index, slot_index)
	local t_width  = icon_lib:get_width()
	local t_height = icon_lib:get_height()
	slot:pos(x, y)
	slot:size(t_width, t_height)
	slot:path(windower.addon_path .. '/images/other/move.png')
	slot:hide()
	slot:alpha(50)
	slot.init_x = x
	slot.init_y = y
	return slot
end

function move_boxes:init(theme_options)
	box_config.icons = {}
	box_config.drag_handles = {}
	self.theme = theme_options
	icon_lib:init(self.theme)
	box_config.count = self.theme.rows
	scaled_icon_width = math.floor(icon_width * self.theme.slot_icon_scale)
	scaled_icon_height = math.floor(icon_height * self.theme.slot_icon_scale)

	for r = 1, self.theme.rows do
		box_config.rows[r] = images.new(table.copy(images_setup, true))
		local offset = self.theme.offsets[tostring(r)]
		box_config.sub_config[r] = {}
		compute_size(box_config.rows[r], box_config.sub_config[r], offset.Vertical)
		box_config.rows[r]:pos(offset.OffsetX, offset.OffsetY)

		local x, y = box_config.rows[r]:pos()
		box_config.sub_config[r].pos_x = x
		box_config.sub_config[r].pos_y = y
		box_config.rows[r]:path(windower.addon_path .. '/images/other/move.png')
		box_config.rows[r]:alpha(30)

		-- Initialize drag handle for this row
		box_config.drag_handles[r] = init_drag_handle(self.theme, r)

		box_config.icons[r] = {}
		box_config.icons[r].slot = {}
		box_config.icons[r].slot[1] = {}
		box_config.icons[r].init_slot = {}
		box_config.icons[r].init_slot[1] = {}
		for s = 1, self.theme.columns do
			box_config.icons[r].slot[s] = self:init_slot(r, s)
			box_config.icons[r].init_slot[s] = {}
			box_config.icons[r].init_slot[s].x, box_config.icons[r].init_slot[s].y = box_config.icons[r].slot[s]:pos()
		end
	end
end

function move_boxes:enable()
	for i = 1, self.theme.rows do
		-- Show drag handles instead of the row overlays for bar movement
		box_config.drag_handles[i]:show()
		-- Still show slot overlays for slot swapping
		for j = 1, self.theme.columns do
			box_config.icons[i].slot[j]:show()
		end
	end
end

function move_boxes:disable()
	for i = 1, self.theme.rows do
		box_config.drag_handles[i]:hide()
		for j = 1, self.theme.columns do
			box_config.icons[i].slot[j]:hide()
		end
	end
end

move_boxes.moved_box_info = {
	pos_x = 0,
	pos_y = 0,
	offset_x = 0, -- offset from click position to bar position
	offset_y = 0,
	box_index = 0,
	slot_index = 0,
	row_active = false,
	slot_active = false,
	swapped_slots = {
		active = false,
		source = { row = 0, slot = 0 },
		dest = { row = 0, slot = 0 },
	},
	removed_slot = {
		active = false,
		source = { row = 0, slot = 0 }
	}
}

--local box_clicked = 0

function move_boxes:get_pos(row)
	return box_config.rows[row]:pos()
end

function move_boxes:get_move_box_info()
	return self.moved_box_info
end

-- Check if a drag handle was clicked
local function check_drag_handle_clicked(theme, x, y)
	for i = 1, theme.rows do
		local handle = box_config.drag_handles[i]
		local pos_x, pos_y = handle:pos()
		local ext = handle:extents()
		local off_x = pos_x + ext
		local off_y = pos_y + 20 -- approximate text height

		if ((pos_x <= x and x <= off_x) or (pos_x >= x and x >= off_x))
			and ((pos_y <= y and y <= off_y) or (pos_y >= y and y >= off_y))
		then
			return i
		end
	end
	return nil
end

function move_boxes:determine_box(x, y)
	found = false
	row_clicked = nil
	slot_clicked = nil

	-- First check slots for icon swapping
	for i = 1, self.theme.rows, 1 do
		for j = 1, self.theme.columns, 1 do
			local pos_x, pos_y = box_config.icons[i].slot[j]:pos()
			local width, height = box_config.icons[i].slot[j]:size()
			local off_x = width + pos_x
			local off_y = height + pos_y
			if ((pos_x <= x and x <= off_x) or (pos_x >= x and x >= off_x))
				and ((pos_y <= y and y <= off_y) or (pos_y >= y and y >= off_y))
			then
				row_clicked = i
				slot_clicked = j
				found = true
				break
			end
		end
	end

	-- If no slot clicked, check drag handles for bar movement
	if found == false then
		row_clicked = check_drag_handle_clicked(self.theme, x, y)
	end

	return row_clicked, slot_clicked
end

function move_boxes:check_slot(x, y)
	local found = false
	local dest_row = 0
	local dest_col = 0
	for i = 1, self.theme.rows, 1 do
		for j = 1, self.theme.columns, 1 do
			local pos_x = box_config.icons[i].init_slot[j].x
			local pos_y = box_config.icons[i].init_slot[j].y
			local width, height = box_config.icons[i].slot[j]:size()
			local off_x = width + pos_x
			local off_y = height + pos_y
			if ((pos_x <= x and x <= off_x) or (pos_x >= x and x >= off_x))
				and ((pos_y <= y and y <= off_y) or (pos_y >= y and y >= off_y))
			then
				if (debug == true) then
					print(string.format("Dropped at Row: %d, Column: %d", i, j))
				end
				dest_row = i
				dest_col = j
				found = true
				break
			end
		end
	end
	return found, dest_row, dest_col
end

function move_boxes:move_hotbars(type, x, y, delta, blocked)
	local offset = 10
	return_value = false
	if type == 1 then -- Mouse left click
		if (debug == true) then
			print(string.format("[Mouse left click] pos_x: %d", x))
		end
		local row_clicked, slot_clicked = move_boxes:determine_box(x, y)
		if (slot_clicked ~= nil) then
			if (debug == true) then
				print(string.format("Row: %d, Column: %d", row_clicked, slot_clicked))
			end
			self.moved_box_info.box_index = row_clicked
			self.moved_box_info.slot_index = slot_clicked
			local pos_x, pos_y = box_config.rows[self.moved_box_info.box_index]:pos()
			self.moved_box_info.pos_y = pos_y
			self.moved_box_info.pos_x = pos_x
			self.moved_box_info.row_active = false
			self.moved_box_info.slot_active = true
			return_value = true
		elseif (row_clicked ~= nil) then
			-- Clicked on drag handle - store offset from mouse to bar position
			if (debug == true) then
				print(string.format("Row: %d (drag handle)", row_clicked))
			end
			self.moved_box_info.box_index = row_clicked
			local pos_x, pos_y = box_config.rows[self.moved_box_info.box_index]:pos()
			-- Store offset so the bar doesn't jump when dragging starts
			self.moved_box_info.offset_x = pos_x - x
			self.moved_box_info.offset_y = pos_y - y
			self.moved_box_info.pos_y = pos_y
			self.moved_box_info.pos_x = pos_x
			self.moved_box_info.row_active = true
			self.moved_box_info.slot_active = false
			return_value = true
		end
	elseif type == 2 then -- Mouse left release
		if (debug == true) then
			print(x)
		end
		if (self.moved_box_info.slot_active == true and row_clicked ~= nil and slot_clicked ~= nil) then
			if (debug == true) then
				print("just dragged")
			end
			local row = self.moved_box_info.box_index
			local col = self.moved_box_info.slot_index
			local init_x = box_config.icons[row].init_slot[col].x
			local init_y = box_config.icons[row].init_slot[col].y
			box_config.icons[row].slot[col]:pos(init_x, init_y)
			local found, dest_row, dest_slot = move_boxes:check_slot(x, y)

			if (found == true) then
				self.moved_box_info.swapped_slots.source.row = row
				self.moved_box_info.swapped_slots.source.slot = col
				self.moved_box_info.swapped_slots.dest.row = dest_row
				self.moved_box_info.swapped_slots.dest.slot = dest_slot
				self.moved_box_info.swapped_slots.active = true
			else
				self.moved_box_info.removed_slot.source.row = row
				self.moved_box_info.removed_slot.source.slot = col
				self.moved_box_info.removed_slot.active = true
			end
			self.moved_box_info.slot_index = 0
			self.moved_box_info.box_index = 0
			self.moved_box_info.slot_active = false
			return_value = true
		end
		if (self.moved_box_info.row_active == true and row_clicked ~= nil) then
			self.moved_box_info.box_index = 0
			self.moved_box_info.row_active = false
			self.moved_box_info.offset_x = 0
			self.moved_box_info.offset_y = 0
			return_value = true
		end
	elseif type == 0 then -- Mouse move
		if (self.moved_box_info.slot_active == true) then
			local row = self.moved_box_info.box_index
			local col = self.moved_box_info.slot_index
			box_config.icons[row].slot[col]:pos_x(x)
			box_config.icons[row].slot[col]:pos_y(y)
			local pos_x, pos_y = box_config.icons[row].slot[col]:pos()
		elseif (self.moved_box_info.row_active == true) then
			-- Calculate new position using offset (smooth dragging without jump)
			local new_x = x + self.moved_box_info.offset_x
			local new_y = y + self.moved_box_info.offset_y

			-- Snap to grid (10px increments)
			new_x = math.floor(new_x / offset) * offset
			new_y = math.floor(new_y / offset) * offset

			-- Update the row overlay position
			box_config.rows[self.moved_box_info.box_index]:pos(new_x, new_y)

			-- Update slot overlay positions so swapping still works correctly
			update_slot_positions(self.theme, self.moved_box_info.box_index, new_x, new_y)

			-- Update the drag handle position
			local bar_offset = self.theme.offsets[tostring(self.moved_box_info.box_index)]
			local handle_x, handle_y
			if bar_offset.Vertical == true then
				handle_x = new_x
				handle_y = new_y - 20
			else
				handle_x = new_x - 45
				handle_y = new_y + (scaled_icon_height / 2) - 8
			end
			box_config.drag_handles[self.moved_box_info.box_index]:pos(handle_x, handle_y)

			self.moved_box_info.pos_y = new_y
			self.moved_box_info.pos_x = new_x
		end
	end

	return return_value
end

return move_boxes
