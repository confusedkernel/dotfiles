vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_try_node_exe = 1

local neoformat_filetypes = {
	css = true,
	haskell = true,
	html = true,
	javascript = true,
	json = true,
	lua = true,
	markdown = true,
	python = true,
	rust = true,
	typst = true,
	typescript = true,
	vue = true,
	xml = true,
}

local format_group = vim.api.nvim_create_augroup("NeoformatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_group,
	pattern = "*",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if not neoformat_filetypes[ft] then
			return
		end

		if vim.fn.exists(":Neoformat") == 0 then
			return
		end

		vim.cmd("silent! undojoin | Neoformat")
	end,
})
