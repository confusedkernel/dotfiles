local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
	vim.cmd "packadd packer.nvim"
end

require "packer".startup(function(use)
	use "wbthomason/packer.nvim"

	----> Appearance <----
	-- Theme
	use "Th3Whit3Wolf/one-nvim"
	use "arzg/vim-colors-xcode"

	-- Vim interactive tutorial
	use "ThePrimeagen/vim-be-good"
	-- Make it rain :)
	use "Eandrju/cellular-automaton.nvim"
	-- Discord presence
	use "andweeb/presence.nvim"
	-- Start page
	use { "startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	}
	-- Auto enable darkmode
	use "f-person/auto-dark-mode.nvim"

	----> Utilities <----
	-- Symbols view
	use "simrat39/symbols-outline.nvim"
	-- Comment shortcut
	use "numToStr/Comment.nvim"
	-- Git diff symbols on the side
	use "lewis6991/gitsigns.nvim"
	-- Auto-indent new line
	use "lukas-reineke/indent-blankline.nvim"
	-- Highlight trailing whitespace
	use "lukoshkin/trailing-whitespace"
	-- Status bar
	use "nvim-lualine/lualine.nvim"
	-- Diff tool
	use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
	-- Auto config tabsize
	use "tpope/vim-sleuth"
	-- Auto-pair parentheses and more
	use "windwp/nvim-autopairs"
	-- Add/change/delete surrounding delimiter pairs
	use "ur4ltz/surround.nvim"
	-- Colorize hex color strings
	use "norcalli/nvim-colorizer.lua"
	-- Multicursor
	use "mg979/vim-visual-multi"
	-- Devicons
	use "nvim-tree/nvim-web-devicons"
	-- Markdown Preview
	use "ellisonleao/glow.nvim"
	-- Interactive Swap
	use "mizlan/iswap.nvim"
	-- Reformat Code
	use "mhartington/formatter.nvim"
	-- Hex Editor 
	use "RaafatTurki/hex.nvim"

	-- Grep / fuzzy finder
	use { "nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" }
	}
	use { "nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cond = vim.fn.executable "make" == 1
	}
	use { "nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	}

	-- Git utilities, i.e. git blame
	use "tpope/vim-fugitive"
	-- Auto-complete snippets
	use "rafamadriz/friendly-snippets"
	-- Highlight todo comments
	use { "folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim"
	 }
	-- Show history as tree
	use "mbbill/undotree"
	-- Terminal
	use {"akinsho/toggleterm.nvim",
		tag = '*'
	}
	-- Auto-complete
	use { "hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	}
	-- Auto Gitignore Generators
	use { "wintermute-cell/gitignore.nvim",
		requires = { "nvim-telescope/telescope.nvim" }
	}
	-- Show directory as tree
	use { 'nvim-tree/nvim-tree.lua',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function()
		require("nvim-tree").setup {}
	end
	}

	----> LSP and AST <----
	-- AST
	use { "nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require "nvim-treesitter.install".update({ with_sync = true })
			ts_update()
		end,
	}
	-- Treesitter
	use "nvim-treesitter/nvim-treesitter-context"
	-- LSP
	use "lukas-reineke/lsp-format.nvim"
	use { "neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	}

	----> Deprecated <----
	-- Tab bar
	use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

	if is_bootstrap then
		require "packer".sync()
	end

end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print "=================================="
	print "    Plugins are being installed"
	print "    Wait until Packer completes,"
	print "       then restart nvim"
	print "=================================="
	return
end
