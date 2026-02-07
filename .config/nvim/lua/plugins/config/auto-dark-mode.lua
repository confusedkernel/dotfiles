local color_mode = require("color-mode")
local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 10000,
	set_light_mode = color_mode.UseLight,
	set_dark_mode = color_mode.UseDark,
})

auto_dark_mode.init()
