local plugin_config = require("plugins.helpers").config

return {
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "mg979/vim-visual-multi", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeShow" } },
	{ "ggandor/leap.nvim", dependencies = "tpope/vim-repeat", keys = { "s", "S" }, config = plugin_config("leap") },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = plugin_config("indent-blankline"),
	},
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		config = plugin_config("origami"),
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = plugin_config("cmp"),
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		event = "InsertEnter",
		config = plugin_config("luasnip"),
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } },
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },
}
