local M = {}
local current_icons = {}
M.aesthetic_menu = function()
	-- TODO: we need to get a table of all lua modules in this folder that aren't init.lua
	current_icons = require("aesthetic_text.icons.nf-md-alpha__box")
	local Popup = require("nui.popup")
	local Layout = require("nui.layout")
	local Input = require("nui.input")
	local preview = Popup({
		border = "double",
	})
	local output = ""

	local input = Input({
		position = "50%",
		size = {
			width = 20,
		},
		border = {
			style = "single",
			text = {
				top = "[Input Text]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		prompt = "> ",
		default_value = "Hello",
		on_close = function()
			print("Input Closed!")
		end,
		on_submit = function(value)
			print("Input Submitted: " .. value)
			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			local row, col = cursor_pos[1], cursor_pos[2]
			vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { output })
		end,
		on_change = function(value)
			output = ""
			-- TODO: add capital letter keys to nf-md-alpha__box
			-- so Barbar will produce 󰬉󰬈󰬙󰬉󰬈󰬙 with all but the B nf-md-alpha__box_outline
			for c in value:gmatch(".") do
				local icon
				if c ~= " " then
					c = string.lower(c)
					icon = current_icons[c] -- look up the icon for each character
				else
					icon = c
				end
				-- process the icon as needed
				output = output .. icon -- concatenate to the new string
			end
		end,
	})

	local layout = Layout(
		{
			position = "50%",
			size = {
				width = 20,
				height = "30%",
			},
		},
		Layout.Box({
			Layout.Box(input, { size = "10%" }),
			Layout.Box(preview, { size = "90%" }),
		}, { dir = "col" })
	)

	local current_dir = "row"

	preview:map("n", "r", function()
		if current_dir == "col" then
			layout:update(Layout.Box({
				Layout.Box(preview, { size = "40%" }),
				Layout.Box(input, { size = "60%" }),
			}, { dir = "row" }))

			current_dir = "row"
		else
			layout:update(Layout.Box({
				Layout.Box(input, { size = "60%" }),
				Layout.Box(preview, { size = "40%" }),
			}, { dir = "col" }))

			current_dir = "col"
		end
	end, {})

	layout:mount()
end

return M
