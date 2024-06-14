vim.loader.enable()

local plugins = {
  -- Appearance & Others
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  {
    "romgrk/barbar.nvim",
    dependencies = "nvim-web-devicons",
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    version = "^1.0.0",
  },

  { "AlexvZyl/nordic.nvim", name = "nordic", lazy = false, priority = 1000 },
  "nvim-lualine/lualine.nvim",
  "f-person/auto-dark-mode.nvim",
  "nvim-tree/nvim-web-devicons",
  "andweeb/presence.nvim",

  -- Utilities
  { "wakatime/vim-wakatime", lazy = false },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", lazy = true },
  { "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim", lazy = true },
  { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "tpope/vim-sleuth", lazy = true },
  { "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim", lazy = true },
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons", lazy = true },
  { "ggandor/leap.nvim", dependencies = "tpope/vim-repeat", enabled = false },
  { "RaafatTurki/hex.nvim", lazy = true },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
  },
  { "github/copilot.vim", lazy = true },
  { "ThePrimeagen/harpoon", lazy = true },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    branch = "2.x.x",
  },
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "nvim-telescope/telescope.nvim" },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
  "numToStr/Comment.nvim",
  "lewis6991/gitsigns.nvim",
  "lukoshkin/highlight-whitespace",
  "windwp/nvim-autopairs",
  "mg979/vim-visual-multi",
  "mizlan/iswap.nvim",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "mbbill/undotree",
  "rafamadriz/friendly-snippets",
  "okuuva/auto-save.nvim",
  "kaarmu/typst.vim",
  "godlygeek/tabular",
  "uga-rosa/ccc.nvim",
  "turbio/bracey.vim",

  -- Telescope related functions
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable "make" == 1 },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },

  -- Which-key
  {
    "folke/which-key.nvim",
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
    },
  },

  -- Neovim Tree Directory
  { "nvim-tree/nvim-tree.lua", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Experimental
  {
    "okuuva/auto-save.nvim",
    lazy = false,
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = {
          { "InsertLeave", "TextChanged" },
        },
      },
      condition = function(buf)
        local fn = vim.fn
        local utils = require "auto-save.utils.data"

        -- don't save for `sql` file types
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "TelescopePrompt" }) then
          return true
        end
        return false
      end,
    },
  },

  -- Testing colorschemes
  {
    "https://github.com/nottyl/curry.nvim",
    branch = "custom-config",
    dev = true,
  },
  {
    "nottyl/nvchad-ui.nvim",
    branch = "master",
    lazy = false,
    priority = 10,
    dev = true,
  },
}

local opts = {
  dev = {
    path = "~/coding/repos/neovim",
  },
}

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
vim.opt.cmdheight = 0

require "keymap"
require "options"

require("lazy").setup(plugins, opts)
