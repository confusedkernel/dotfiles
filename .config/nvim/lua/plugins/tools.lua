local plugin_config = require("plugins.helpers").config

return {
	{ "krivahtoo/silicon.nvim", build = "./install.sh build", cmd = "Silicon", config = plugin_config("silicon") },
	{ "lukoshkin/highlight-whitespace", event = { "BufReadPre", "BufNewFile" } },
	{ "uga-rosa/ccc.nvim", event = { "BufReadPre", "BufNewFile" }, config = plugin_config("color") },
	{ "sbdchd/neoformat", event = { "BufWritePre" }, config = plugin_config("neoformat") },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<C-`>", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Toggle terminal" },
		},
		config = plugin_config("toggleterm"),
	},
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", event = "BufReadPost", config = plugin_config("todo-comments") },
	{ "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim", cmd = { "Spectre" } },
	{ "RaafatTurki/hex.nvim", cmd = { "HexToggle" }, opts = {} },
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		config = plugin_config("obsidian"),
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
