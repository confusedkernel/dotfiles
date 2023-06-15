local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.cmdheight = 0

require('keymap')
require('options')

require('lazy').setup({
  -- Appearance & Others
  { 'Th3Whit3Wolf/one-nvim', name = 'one-nvim' },
  { 'catppuccin/nvim', name = 'catppuccin', lazy =false, priority = 1000 },
  { 'nottyl/nordic.nvim', name = 'nordic', lazy = false, priority = 1000 },
  { 'ThePrimeagen/vim-be-good', lazy = true },
  { 'Eandrju/cellular-automaton.nvim', lazy = true },
  { 'startup-nvim/startup.nvim', dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }},
  'f-person/auto-dark-mode.nvim',
  'nvim-tree/nvim-web-devicons',
  'andweeb/presence.nvim',


  -- Utilities
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'romgrk/barbar.nvim', dependencies = 'nvim-web-devicons', lazy = true, },
  { 'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },},
  { 'ellisonleao/glow.nvim', config = true, cmd = 'Glow' },
  { 'wintermute-cell/gitignore.nvim', dependencies =  'nvim-telescope/telescope.nvim', lazy = true },
  { 'folke/todo-comments.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'utilyre/barbecue.nvim', name = 'barbecue', version = '*',
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons', },
    lazy = false,
  },
  'simrat39/symbols-outline.nvim',
  'numToStr/Comment.nvim',
  'lewis6991/gitsigns.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'lukoshkin/highlight-whitespace',
  'tpope/vim-sleuth',
  'windwp/nvim-autopairs',
  'ur4ltz/surround.nvim',
  'NvChad/nvim-colorizer.lua',
  'mg979/vim-visual-multi',
  'nvim-lualine/lualine.nvim',
  'mizlan/iswap.nvim',
  'tpope/vim-surround',
  'ThePrimeagen/harpoon',
  'RaafatTurki/hex.nvim',
  'tpope/vim-fugitive',
  'rafamadriz/friendly-snippets',
  'mbbill/undotree',
  'pocco81/auto-save.nvim',

  -- Telescope related functions
  { 'nvim-telescope/telescope-file-browser.nvim', dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }},
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1},
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' }},

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',},
  -- 'nvim-treesitter/nvim-treesitter-context',

  -- Which-key
  { 'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  -- LSP
  'lukas-reineke/lsp-format.nvim',
  { 'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy' },
      'folke/neodev.nvim',
    },
  },

  -- Neovim Tree Directory
  { 'nvim-tree/nvim-tree.lua', version = '*', dependencies = { 'nvim-tree/nvim-web-devicons' ,}},

  -- Experimental
  -- 'rcarriga/nvim-notify',
  { 'folke/noice.nvim', event = "VeryLazy", dependencies = { 'MunifTanjim/nui.nvim'}},

})

