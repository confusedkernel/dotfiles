require("catppuccin").setup({
	float = {
		transparent = false, -- enable transparent floating windows
		solid = false, -- use solid styling for floating windows, see |winborder|
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
