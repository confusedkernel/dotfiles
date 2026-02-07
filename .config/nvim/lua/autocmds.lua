local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = group("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = yank_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

local filetype_group = group("LocalFiletypeOptions", { clear = true })
autocmd("FileType", {
	group = filetype_group,
	pattern = { "markdown", "tex" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

autocmd("FileType", {
	group = filetype_group,
	pattern = "rust",
	callback = function()
		vim.opt_local.iskeyword:append("&")
	end,
})

autocmd("FileType", {
	group = filetype_group,
	pattern = "fish",
	callback = function()
		vim.opt_local.iskeyword:append("$")
	end,
})

local startup_group = group("StartupActions", { clear = true })
autocmd("VimEnter", {
	group = startup_group,
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if vim.fn.isdirectory(bufname) ~= 1 then
			return
		end

		require("lazy").load({ plugins = { "telescope.nvim" } })

		local ok, telescope = pcall(require, "telescope")
		if not ok or not telescope.extensions or not telescope.extensions.file_browser then
			return
		end

		telescope.extensions.file_browser.file_browser({ cwd = bufname })
	end,
})
