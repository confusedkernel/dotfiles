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

require("lazy").setup({
	-- Appearance & Others
	{ "nottyl/one-nvim", name = "one-nvim", lazy = true, branch = 'lualine-support' },
	-- { "catppuccin/nvim", name = "catppuccin" },
	{ 'nottyl/catppuccin-nvim', name = 'catppuccin', branch = 'test' },
	{ "nottyl/nordic.nvim", name = "nordic", lazy = false, priority = 1000 },
	{ "ThePrimeagen/vim-be-good", lazy = true },
	{ "Eandrju/cellular-automaton.nvim", lazy = true },
	-- { 'startup-nvim/startup.nvim', dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' } },
	{
		"glepnir/dashboard-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		lazy = false,
		priority = 100,
	},
	"nvim-lualine/lualine.nvim",
	"f-person/auto-dark-mode.nvim",
	"nvim-tree/nvim-web-devicons",
	"andweeb/presence.nvim",

	-- Utilities
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", lazy = true },
	{ "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
	{ "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" } },
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow", lazy = true },
	{ "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim", lazy = true },
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "tpope/vim-sleuth", lazy = true },
	{ "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim", lazy = true },
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = true },
	{ "ggandor/leap.nvim", dependencies = "tpope/vim-repeat", lazy = true },
	{ "utilyre/barbecue.nvim", name = "barbecue", version = "*", dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },},
	{ "RaafatTurki/hex.nvim", lazy = true },
    { "simrat39/rust-tools.nvim", dependencies = {"neovim/nvim-lspconfig", "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap"}, lazy = true },
	"simrat39/symbols-outline.nvim",
	"numToStr/Comment.nvim",
	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"lukoshkin/highlight-whitespace",
	"windwp/nvim-autopairs",
	"ur4ltz/surround.nvim",
	"NvChad/nvim-colorizer.lua",
	"mg979/vim-visual-multi",
	"mizlan/iswap.nvim",
	"tpope/vim-surround",
	"ThePrimeagen/harpoon",
	"tpope/vim-fugitive",
	"rafamadriz/friendly-snippets",
	"mbbill/undotree",
	"pocco81/auto-save.nvim",

	-- Telescope related functions
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-context", enabled = false },

	-- Which-key
	{
		"folke/which-key.nvim",
		lazy = true,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},

	-- LSP
	"lukas-reineke/lsp-format.nvim",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy" },
			"folke/neodev.nvim",
		},
	},

	-- Neovim Tree Directory
	{ "nvim-tree/nvim-tree.lua", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- Experimental
	{ "folke/noice.nvim", event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim" } },
})
