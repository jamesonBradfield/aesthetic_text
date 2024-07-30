local M = {}
local current_icons = {}
local keystrokes = {}
local is_aesthetic_insert
M.start_aesthetic_insert = function(icon_name)
	is_aesthetic_insert = true
	current_icons = require("aesthetic_text." .. icon_name)
	for key, value in pairs(current_icons) do
		print(key, value)
	end
	-- we need to map this out, I have done this in telekasten note
	-- vim.on_key(function(key, typed)
	-- 	if vim.api.nvim_get_mode()["mode"] == "i" then
	-- 		local current_line_number, cursor_position = unpack(vim.api.nvim_win_get_cursor(0))
	-- 		local line_till_cursor = vim.api.nvim_buf_get_text(
	-- 			0,
	-- 			current_line_number - 1,
	-- 			0,
	-- 			current_line_number - 1,
	-- 			cursor_position,
	-- 			{}
	-- 		)[1]
	-- 		local current_line = vim.api.nvim_buf_get_lines(0, current_line_number - 1, current_line_number, true)[1]
	-- 		vim.api.nvim_buf_set_lines(0, current_line_number - 1, current_line_number, true, { new_line })
	-- 	end
	-- end)
end
M.stop_aesthetic_insert = function()
	is_aesthetic_insert = false
	vim.on_key(nil)
end
-- toggle doesn't work yet
M.toggle_aesthetic_insert = function(icon_name)
	if is_aesthetic_insert then
		M.stop_aesthetic_insert()
	else
		M.start_aesthetic_insert(icon_name)
	end
end
return M
