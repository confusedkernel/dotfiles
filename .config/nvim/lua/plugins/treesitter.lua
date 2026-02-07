local plugin_config = require("plugins.helpers").config

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = plugin_config("treesitter"),
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		config = plugin_config("markdown"),
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
}
