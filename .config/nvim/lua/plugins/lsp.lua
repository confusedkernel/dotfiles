local plugin_config = require("plugins.helpers").config

return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		ft = { "rust" },
		init = plugin_config("rustaceanvim"),
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^6",
		ft = { "haskell", "lhaskell", "cabal" },
		init = plugin_config("haskell-tools"),
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = plugin_config("lsp"),
		dependencies = {
			{ "williamboman/mason.nvim" },
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "j-hui/fidget.nvim", tag = "legacy", config = plugin_config("fidget") },
		},
	},
	{ "lukas-reineke/lsp-format.nvim", event = "LspAttach" },
}
