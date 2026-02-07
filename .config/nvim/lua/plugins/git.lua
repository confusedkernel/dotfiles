local plugin_config = require("plugins.helpers").config

return {
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, config = plugin_config("gitsigns") },
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
		config = plugin_config("fugitive"),
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
		config = plugin_config("diffview"),
	},
	{ "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim", cmd = { "Gitignore" } },
}
