vim.loader.enable()

local function plugin_config(name)
	return function()
		require("plugins.config." .. name)
	end
end

local plugins = {
	------------------------
	-- Appearance & Stats --
	------------------------
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy", config = plugin_config("lualine") },
	{ "f-person/auto-dark-mode.nvim", lazy = false, config = plugin_config("auto-dark-mode") },
	"nvim-tree/nvim-web-devicons",
	{ "krivahtoo/silicon.nvim", build = "./install.sh build", cmd = "Silicon", config = plugin_config("silicon") },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, config = plugin_config("catppuccin") },
	{ "AlexvZyl/nordic.nvim", name = "nordic", lazy = false, priority = 900, config = plugin_config("nordic") },
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-web-devicons",
		version = "^1.0.0",
		event = "VeryLazy",
		config = plugin_config("barbar"),
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPost",
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
		ft = { "rust" },
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^6",
		ft = { "haskell", "lhaskell", "cabal" },
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
		event = { "BufReadPre", "BufNewFile" },
		config = plugin_config("lsp"),
		dependencies = {
			{ "williamboman/mason.nvim" },
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "j-hui/fidget.nvim", tag = "legacy", config = plugin_config("fidget") },
		},
	},

	----------------------
	-- Misc / utilities --
	----------------------
	{ "numToStr/Comment.nvim", event = "VeryLazy", config = plugin_config("comment") },
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, config = plugin_config("gitsigns") },
	{ "lukoshkin/highlight-whitespace", event = { "BufReadPre", "BufNewFile" } },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = plugin_config("autopairs") },
	{ "mg979/vim-visual-multi", event = "VeryLazy" },
	{ "lukas-reineke/lsp-format.nvim", event = "LspAttach" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
		config = plugin_config("fugitive"),
	},
	{ "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeShow" }, config = plugin_config("undotree") },
	{ "uga-rosa/ccc.nvim", event = { "BufReadPre", "BufNewFile" }, config = plugin_config("color") },
	{ "sbdchd/neoformat", cmd = { "Neoformat" } },
	{ "mizlan/iswap.nvim", event = "VeryLazy", config = plugin_config("iswap") },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = plugin_config("tree"),
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<C-`>", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Toggle terminal" },
		},
		config = plugin_config("toggleterm"),
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
		config = plugin_config("diffview"),
	},
	{ "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim", cmd = { "Gitignore" } },
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", event = "BufReadPost", config = plugin_config("todo-comments") },
	{ "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } },
	{ "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim", cmd = { "Spectre" } },
	{ "ggandor/leap.nvim", dependencies = "tpope/vim-repeat", keys = { "s", "S" }, config = plugin_config("leap") },
	{ "RaafatTurki/hex.nvim", cmd = { "HexToggle" }, config = plugin_config("hex") },
	{ "lukas-reineke/indent-blankline.nvim", event = { "BufReadPre", "BufNewFile" }, config = plugin_config("indent-blankline") },
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		config = plugin_config("origami"),

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
		config = plugin_config("obsidian"),
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
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
		event = "InsertEnter",
		config = plugin_config("luasnip"),
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = plugin_config("which-key"),
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		config = plugin_config("markdown"),
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you use the mini.nvim suite
	},

	---------------
	-- Telescope --
	---------------
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = { "Telescope" },
		keys = {
			{ "<leader>?" },
			{ "<leader>/" },
			{ "<leader>sf" },
			{ "<leader>gf" },
			{ "<leader>sh" },
			{ "<leader>sw" },
			{ "<leader>sg" },
			{ "<leader>sd" },
		},
		config = plugin_config("telescope"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	----------------
	-- Treesitter --
	----------------
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "OXY2DEV/markview.nvim", enabled = false },
		build = ":TSUpdate",
		config = plugin_config("treesitter"),
	},
	{ "nvim-treesitter/nvim-treesitter-context", enabled = false },

	------------------------
	-- Plugin Development --
	------------------------
	{
		"confusedkernel/nvchad-ui.nvim",
		branch = "master",
		lazy = false,
		priority = 10,
		dev = true,
		config = plugin_config("dash"),
	},
	{
		"confusedkernel/center-stage.nvim",
		branch = "master",
		event = "VeryLazy",
		priority = 10,
		dev = true,
		opts = {
			enabled = true,
			center_on = { "CursorMovedI" },
			offset = -2,
		},
	},
}

local opts = {
	dev = {
		path = "~/coding/repos/neovim",
	},
	change_detection = {
		notify = false,
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
require("autocmds")
require("commands")

require("lazy").setup(plugins, opts)

vim.opt.background = "light"
vim.cmd.colorscheme("catppuccin-latte")
