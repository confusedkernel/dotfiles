local palette = require("nordic.colors")

require("nordic").setup({
	theme = "nordic",
	bright_border = true,
	noice = {
		-- Available styles: `classic`, `flat`.
		style = "flat",
	},
	on_highlight = {
		WinBar = {
			bg = palette.gray0,
		},
		WinBarNC = {
			bg = palette.gray0,
		},
	},
})
