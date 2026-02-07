local auto_dark_mode = require("auto-dark-mode")

local function set_light_mode()
	vim.cmd("colorscheme catppuccin-latte")
end

local function set_dark_mode()
	vim.cmd("colorscheme nordic")
end

auto_dark_mode.setup({
	update_interval = 10000,
	set_light_mode = set_light_mode,
	set_dark_mode = set_dark_mode,
})

auto_dark_mode.init()
