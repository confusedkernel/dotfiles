local plugin_config = require("plugins.helpers").config

local mason_cmds = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" }

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
	},
	-- Mason only needs to load for its UI/installer; its bin dir is put on PATH
	-- in lua/options.lua so servers resolve without it.
	{
		"mason-org/mason.nvim",
		cmd = mason_cmds,
		build = ":MasonUpdate",
		opts = { PATH = "skip" },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		cmd = mason_cmds,
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "ts_ls", "vue_ls", "cssls", "jsonls", "lemminx" },
			automatic_installation = false,
			automatic_enable = false,
		},
	},
	{ "j-hui/fidget.nvim", event = "LspAttach", config = plugin_config("fidget") },
}
