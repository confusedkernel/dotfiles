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

require("lazy").setup {
  -- Appearance & Others
  { "leana8959/one-nvim", lazy = true },
  -- { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
  { "AlexvZyl/nordic.nvim", name = "nordic", lazy = false, priority = 1000 },
  { "Eandrju/cellular-automaton.nvim", lazy = true },
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
  { "wakatime/vim-wakatime", lazy = false },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", lazy = true },
  { "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim", lazy = true },
  { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "tpope/vim-sleuth", lazy = true },
  { "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim", lazy = true },
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons", lazy = true },
  { "ggandor/leap.nvim", dependencies = "tpope/vim-repeat", enabled = false },
  { "RaafatTurki/hex.nvim", lazy = true },
  { "simrat39/rust-tools.nvim", dependencies = "neovim/nvim-lspconfig" },
  { "ggandor/leap.nvim", dependencies = "tpope/vim-repeat" },
  { "ThePrimeagen/harpoon", lazy = true },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
  },
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
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
    lazy = true,
  },
  "numToStr/Comment.nvim",
  "lewis6991/gitsigns.nvim",
  "lukoshkin/highlight-whitespace",
  "windwp/nvim-autopairs",
  "NvChad/nvim-colorizer.lua",
  "mg979/vim-visual-multi",
  "mizlan/iswap.nvim",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "rafamadriz/friendly-snippets",
  "mbbill/undotree",
  "pocco81/auto-save.nvim",
  "kaarmu/typst.vim",
  "godlygeek/tabular",
  "rush-rs/tree-sitter-asm",
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
      "folke/neodev.nvim",
    },
  },

  -- Neovim Tree Directory
  { "nvim-tree/nvim-tree.lua", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Unused (but might be useful some day)
  -- {
  --     'akinsho/bufferline.nvim',
  --     version = "*",
  --     dependencies = 'nvim-tree/nvim-web-devicons',
  --     enabled = false
  -- },
  -- { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim"}},
  -- "Bekaboo/dropbar.nvim",
  -- "godlygeek/tabular",
  -- { "simrat39/symbols-outline.nvim", lazy = true },
}
