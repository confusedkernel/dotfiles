local M = {}

local map = vim.keymap.set

M.border = {
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
}

local function lsp_references_picker()
	local ok, telescope_builtin = pcall(require, "telescope.builtin")
	if ok then
		telescope_builtin.lsp_references()
		return
	end

	vim.lsp.buf.references()
end

function M.on_attach(client, bufno)
	if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufno })
	end

	map("n", "K", function()
		vim.lsp.buf.hover({ border = M.border })
	end, { desc = "LSP Hover", buffer = bufno })
	map("n", "<C-k>", function()
		vim.lsp.buf.signature_help({ border = M.border })
	end, { desc = "LSP Signature help", buffer = bufno })
	map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufno })
	map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufno })
	map("n", "gtd", vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufno })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufno })
	map("n", "gu", lsp_references_picker, { desc = "LSP Usages", buffer = bufno })
	map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufno })
	map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Code lens", buffer = bufno })
	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "LSP format", buffer = bufno })
	map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename symbol", buffer = bufno })

	if vim.lsp.inlay_hint then
		map("n", "<leader>ih", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufno })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufno })
		end, { desc = "Toggle Inlay Hints", buffer = bufno })
	end
end

return M
