vim.loader.enable()

local plugins = {
	------------------------
	-- Appearance & Stats --
	------------------------
	"nvim-lualine/lualine.nvim",
	"f-person/auto-dark-mode.nvim",
	"nvim-tree/nvim-web-devicons",
	{ "krivahtoo/silicon.nvim", run = "./install.sh build" },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false },
	{ "AlexvZyl/nordic.nvim", name = "nordic", lazy = false, priority = 1000 },
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-web-devicons",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		version = "^1.0.0",
	},
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
	},

	----------------------
	-- Language Servers --
	----------------------
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
	},
	{
		"mrcjkb/haskell-tools.nvim",
		lazy = false,
		version = "^6",
	},
	-- configures the lua lsp to function with neovim
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy" },
		},
	},

	----------------------
	-- Misc / utilities --
	----------------------
	"numToStr/Comment.nvim",
	"lewis6991/gitsigns.nvim",
	"lukoshkin/highlight-whitespace",
	"windwp/nvim-autopairs",
	"mg979/vim-visual-multi",
	"lukas-reineke/lsp-format.nvim",
	"tpope/vim-surround",
	"tpope/vim-fugitive",
	"mbbill/undotree",
	"rafamadriz/friendly-snippets",
	"uga-rosa/ccc.nvim",
	"sbdchd/neoformat",
	{ "mizlan/iswap.nvim", event = "VeryLazy" },
	{ "nvim-tree/nvim-tree.lua", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", lazy = true },
	{ "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim", lazy = true },
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "tpope/vim-sleuth", lazy = true },
	{ "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim", lazy = true },
	{ "ggandor/leap.nvim", dependencies = "tpope/vim-repeat" },
	{ "RaafatTurki/hex.nvim", lazy = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {}, -- needed even when using default config

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	-- {
	-- 	"okuuva/auto-save.nvim",
	-- 	lazy = false,
	-- 	cmd = "ASToggle",
	-- 	event = { "InsertLeave", "TextChanged" },
	-- 	opts = {
	-- 		enabled = true,
	-- 		trigger_events = {
	-- 			immediate_save = {
	-- 				{ "InsertLeave", "TextChanged" },
	-- 			},
	-- 		},
	-- 		condition = function(buf)
	-- 			local fn = vim.fn
	-- 			local utils = require("auto-save.utils.data")
	--
	-- 			-- don't save for `sql` file types
	-- 			if utils.not_in(fn.getbufvar(buf, "&filetype"), { "TelescopePrompt" }) then
	-- 				return true
	-- 			end
	-- 			return false
	-- 		end,
	-- 	},
	-- },

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	---------------
	-- Telescope --
	---------------
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
	},

	----------------
	-- Treesitter --
	----------------
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "OXY2DEV/markview.nvim", enabled = false },
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-context", enabled = false },

	------------------------
	-- Plugin Development --
	------------------------
	{
		"https://github.com/leana8959/curry.nvim",
		-- dev = true,
	},
	{
		"confusedkernel/nvchad-ui.nvim",
		branch = "master",
		lazy = false,
		priority = 10,
		-- dev = true,
	},
	{
		"confusedkernel/center-stage.nvim",
		branch = "master",
		lazy = false,
		priority = 10,
		-- dev = true,
		opts = {
			enabled = true,
		},
	},
}

local opts = {
	dev = {
		path = "~/coding/repos/neovim",
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.opt.cmdheight = 0

require("keymap")
require("options")

require("lazy").setup(plugins, opts)

vim.opt.background = "light"
vim.cmd.colorscheme("catppuccin")
