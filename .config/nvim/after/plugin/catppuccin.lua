require("catppuccin").setup({
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
			}
		end,
	},
	integrations = {
		barbar = false,
		harpoon = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		noice = {
			enabled = true,
			style = "nvchad",
		},
		notify = true,
		which_key = true,
	},
})
