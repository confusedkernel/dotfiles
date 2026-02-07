require("nordic").setup({
	theme = "nordic",
	bright_border = true,
	noice = {
		-- Available styles: `classic`, `flat`.
		style = "flat",
	},
	on_highlight = function(highlights, palette)
		highlights.WinBar = {
			bg = palette.gray0,
		}
		highlights.WinBarNC = {
			bg = palette.gray0,
		}
	end,
})
