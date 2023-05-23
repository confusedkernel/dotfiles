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
  --> Appearance <--
  -- Themes
  { 'Th3Whit3Wolf/one-nvim', name = 'one-nvim'},
  { 'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic' .load()
    end
  },
  -- Vim interactive tutorial
  'ThePrimeagen/vim-be-good',
  -- Fun ADHD trap
  'Eandrju/cellular-automaton.nvim',
  -- Discord presence
  'andweeb/presence.nvim',
  -- Startup screen
  { 'startup-nvim/startup.nvim', dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }},
  -- Auto dark mode
  'f-person/auto-dark-mode.nvim',
  -- Neovim devicons
  'nvim-tree/nvim-web-devicons',

  --> Utilities --<
  -- Symbols view
  'simrat39/symbols-outline.nvim',
  -- Comment shortcut
  'numToStr/Comment.nvim',
  -- Git diff symbols on the side
  'lewis6991/gitsigns.nvim',
  -- Auto-indent new line
  'lukas-reineke/indent-blankline.nvim',
  -- Highlight trailing whitespace
  'lukoshkin/trailing-whitespace',
  -- Diff tool
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  -- Heuristically set buffer options
  'tpope/vim-sleuth',
  -- Auto-pair parentheses and more
  'windwp/nvim-autopairs',
  -- Add/change/delete surrounding delimiter pairs
  'ur4ltz/surround.nvim',
  -- Colorize hex color strings
  'norcalli/nvim-colorizer.lua',
  -- Multicursor
  'mg979/vim-visual-multi',
  -- Markdown Preview
  'ellisonleao/glow.nvim',
  -- Status bar
  'nvim-lualine/lualine.nvim',
  -- Interactive Swap
  'mizlan/iswap.nvim',
  -- Surround
  'tpope/vim-surround',
  -- Reformat Code
  'mhartington/formatter.nvim',
  -- Harpoon?
  'ThePrimeagen/harpoon',
  -- Hex Editor 
  'RaafatTurki/hex.nvim',
  -- Highlight todo comments
  { 'folke/todo-comments.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  -- Git utilities, i.e. git blame
  'tpope/vim-fugitive',
  -- Autosave
  'Pocco81/auto-save.nvim',
  -- Auto-complete snippets
  'rafamadriz/friendly-snippets',
  -- Show history as tree
  'mbbill/undotree',
  -- Terminal
  { 'akinsho/toggleterm.nvim', version = '*' },
  -- Gitignore generator
  { 'wintermute-cell/gitignore.nvim', dependencies =  'nvim-telescope/telescope.nvim' },
  -- Auto-complete
  { 'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },},

  -- Telescope related functions
  { 'nvim-telescope/telescope-file-browser.nvim', dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }},
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1},
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' }},
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',},
  'nvim-treesitter/nvim-treesitter-context',

  -- Prettier diagnostic list
  { 'folke/trouble.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
  -- Helps you learn neovim
  { 'folke/which-key.nvim',
    config = function()
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
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
  },
  -- Neovim Tree Directory
  { 'nvim-tree/nvim-tree.lua', version = '*', dependencies = { 'nvim-tree/nvim-web-devicons' ,},
    config = function()
        require('nvim-tree').setup {}
    end,
  },

  -- Barbar (I'm removing this)
  {'romgrk/barbar.nvim', dependencies = 'nvim-web-devicons'},
} )

