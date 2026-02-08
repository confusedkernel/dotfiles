local plugin_config = require("plugins.helpers").config

return {
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy", config = plugin_config("lualine") },
	{ "f-person/auto-dark-mode.nvim", event = "VeryLazy", config = plugin_config("auto-dark-mode") },
	"nvim-tree/nvim-web-devicons",
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		lazy = false,
		priority = 900,
		config = plugin_config("colorschemes"),
	},
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-web-devicons",
		version = "^1.0.0",
		event = "VeryLazy",
		config = plugin_config("barbar"),
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = plugin_config("tree"),
	},
	{
		"confusedkernel/nvchad-ui.nvim",
		branch = "master",
		lazy = false,
		priority = 10,
		dev = true,
		config = plugin_config("dash"),
	},
	{
		"confusedkernel/center-stage.nvim",
		branch = "master",
		event = "VeryLazy",
		priority = 10,
		dev = true,
		opts = {
			enabled = true,
			center_on = { "CursorMovedI" },
			offset = -2,
		},
	},
}
