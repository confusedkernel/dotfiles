require("silicon").setup({
	font = "CaskaydiaCove Nerd Font=26",
	theme = "mocha",
	line_number = true,
	background = "#1d3b6b", -- (string) The background color for the screenshot.
	shadow = {
		blur_radius = 0.0, -- (number) The blur radius for the shadow, set to 0.0 for no shadow.
		offset_x = 1, -- (number) The horizontal offset for the shadow.
		offset_y = 1, -- (number) The vertical offset for the shadow.
		color = "#000000", -- (string) The color for the shadow.
	},
	output = {
		-- (boolean) Whether to copy the image to clipboard instead of saving to file.
		clipboard = true,
		-- (string) Where to save images, defaults to the current directory.
		--  e.g. /home/user/Pictures
		path = ".",
		-- (string) The filename format to use. Can include placeholders for date and time.

		format = "silicon_[year][month][day]_[hour][minute][second].png",
	},
	round_corner = true,
	window_title = function()
		return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
	end,
})
