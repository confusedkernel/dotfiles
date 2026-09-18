vim.loader.enable()

local plugins = require("plugins")

local opts = {
	dev = {
		path = "~/coding/repos/neovim",
	},
	install = {
		colorscheme = { "nordic", "catppuccin-latte" },
	},
	change_detection = {
		notify = false,
	},
	rocks = {
		enabled = false,
	},
	performance = {
		rtp = {
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

require("keymap")
require("options")
require("autocmds")
require("commands")

require("lazy").setup(plugins, opts)

require("color-mode").ApplySystemTheme()
