local prettier = { "prettierd", "prettier", stop_after_first = true }

-- Filetypes that are formatted automatically on save. Everything else is only
-- formatted on <leader>f (see lua/keymap.lua).
local format_on_save_filetypes = {
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

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		python = { "black" },
		haskell = { "fourmolu" },
		typst = { "typstyle" },
		css = prettier,
		html = prettier,
		javascript = prettier,
		typescript = prettier,
		json = prettier,
		markdown = prettier,
		vue = prettier,
		-- xml: no external formatter configured, falls back to the LSP (lemminx)
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = function(bufnr)
		if not format_on_save_filetypes[vim.bo[bufnr].filetype] then
			return nil
		end
		return { timeout_ms = 1000 }
	end,
	notify_no_formatters = false,
})
