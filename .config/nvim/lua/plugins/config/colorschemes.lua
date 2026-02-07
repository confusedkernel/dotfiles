require("catppuccin").setup({
	float = {
		transparent = false,
		solid = false,
	},
	color_overrides = {
		latte = {
			base = "#fafafa",
			mantle = "#e6e6e6",
			crust = "#dcdcdc",
		},
		frappe = {},
		macchiato = {},
		mocha = {},
	},
	highlight_overrides = {
		latte = function(C)
			return {
				BufferCurrent = { bg = "#fafafa", fg = C.text },
				BufferCurrentIndex = { bg = "#fafafa", fg = C.blue },
				BufferCurrentMod = { bg = "#fafafa", fg = C.yellow },
				BufferCurrentSign = { bg = "#fafafa", fg = C.blue },
				BufferCurrentTarget = { bg = "#fafafa", fg = C.red },
				Special = { fg = C.blue },
				TelescopeTitle = { bg = C.lavender, fg = C.base },
				TelescopePromptBorder = { bg = C.crust },
				TelescopePromptNormal = { link = "TelescopePromptBorder" },
				LeapBackdrop = { link = "Comment" },
			}
		end,
	},
	integrations = {
		barbar = false,
		harpoon = true,
		leap = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		which_key = true,
	},
})

require("nordic").setup({
	theme = "nordic",
	bright_border = true,
	noice = {
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
