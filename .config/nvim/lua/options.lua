-- Mason installs language servers here. Putting the directory on PATH up
-- front means servers resolve without loading mason.nvim on every file open.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.shortmess:append({ I = true })
vim.opt.showmode = false
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.confirm = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.cmdheight = 0
vim.opt.scrolloff = 8

-- Default border for floating windows (LSP hover, signature help, diagnostics).
-- "solid" is a one-cell padded border drawn in FloatBorder.
vim.opt.winborder = "solid"
