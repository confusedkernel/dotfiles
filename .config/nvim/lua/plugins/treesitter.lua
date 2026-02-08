local plugin_config = require("plugins.helpers").config

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = plugin_config("treesitter"),
	},
	{
		"OXY2DEV/markview.nvim",
		-- lazy = false,
		ft = { "markdown", "mdx", "quarto", "rmd" },
		config = plugin_config("markview"),
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
