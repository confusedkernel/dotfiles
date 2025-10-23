vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.shortmess:append({ I = true })
vim.opt.showmode = false

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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.scrolloff = 8

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function()
		vim.cmd("set iskeyword+=&")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "fish" },
	callback = function()
		vim.cmd("set iskeyword+=$")
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if vim.fn.isdirectory(bufname) == 1 then
			require("telescope").extensions.file_browser.file_browser({ cwd = bufname })
		end
	end,
})

vim.cmd('command! UseLight lua require("color-mode").UseLight()')
vim.cmd('command! UseDark lua require("color-mode").UseDark()')
vim.cmd('command! ColorToggle lua require("color-mode").ColorToggle()')
vim.api.nvim_set_keymap("n", "<leader>C", ":ColorToggle<CR>", { silent = true })

-- vim.o.foldenable = true
-- vim.o.foldlevel = 99
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- vim.o.foldtext = ""
-- vim.opt.foldcolumn = "0"
-- vim.opt.fillchars:append({ fold = " " })

-- vim.cmd.colorscheme "one-nvim"
