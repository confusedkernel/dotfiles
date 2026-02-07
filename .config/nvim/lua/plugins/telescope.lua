local plugin_config = require("plugins.helpers").config

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = { "Telescope" },
		keys = {
			{ "<leader>?" },
			{ "<leader>/" },
			{ "<leader>sf" },
			{ "<leader>gf" },
			{ "<leader>sh" },
			{ "<leader>sw" },
			{ "<leader>sg" },
			{ "<leader>sd" },
		},
		config = plugin_config("telescope"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
