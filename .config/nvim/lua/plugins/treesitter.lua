local plugin_config = require("plugins.helpers").config

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "OXY2DEV/markview.nvim", enabled = false },
		build = ":TSUpdate",
		config = plugin_config("treesitter"),
	},
	{ "nvim-treesitter/nvim-treesitter-context", enabled = false },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		config = plugin_config("markdown"),
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
}
