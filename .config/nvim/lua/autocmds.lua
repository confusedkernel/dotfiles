local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = group("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = yank_group,
	callback = function()
		vim.hl.on_yank()
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

local fugitive_group = group("FugitiveKeymaps", { clear = true })
autocmd("FileType", {
	group = fugitive_group,
	pattern = "fugitive",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader><space>",
			"<cmd>q<CR>",
			{ desc = "Close fugitive status", buffer = true, silent = true }
		)
	end,
})

autocmd("FileType", {
	group = fugitive_group,
	pattern = "fugitiveblame",
	callback = function()
		vim.keymap.set("n", "<leader>gb", "<cmd>q<CR>", { desc = "Close fugitive blame", buffer = true, silent = true })
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

local lsp_group = group("LspKeymaps", { clear = true })
autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		local bufnr = args.buf
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
		end

		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		map("K", vim.lsp.buf.hover, "LSP Hover")
		map("<C-k>", vim.lsp.buf.signature_help, "LSP Signature help")
		map("gD", vim.lsp.buf.declaration, "LSP Declaration")
		map("gd", vim.lsp.buf.definition, "LSP Definitions")
		map("gtd", vim.lsp.buf.type_definition, "LSP Type definitions")
		map("gi", vim.lsp.buf.implementation, "LSP Implementations")
		map("gu", function()
			local ok, builtin = pcall(require, "telescope.builtin")
			if ok then
				builtin.lsp_references()
			else
				vim.lsp.buf.references()
			end
		end, "LSP Usages")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>cl", vim.lsp.codelens.run, "Code lens")
		map("<leader>r", vim.lsp.buf.rename, "LSP Rename symbol")
		map("<leader>ih", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
		end, "Toggle Inlay Hints")
	end,
})
