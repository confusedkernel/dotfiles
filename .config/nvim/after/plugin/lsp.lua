require("fidget").setup({
	text = {
		spinner = "dots",
		-- done = "[Ok]",
	},
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_installation = false,
})
require("neodev").setup()

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "LSP Float", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"[d",
	vim.diagnostic.goto_prev,
	{ desc = "Go to previous diagnostic", noremap = true, silent = true }
)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", noremap = true, silent = true })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Show LSP in list", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- See `:help vim.lsp.*`
	local ts = require("telescope.builtin")

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufnr })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature help", buffer = bufnr })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
	vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
	vim.keymap.set("n", "gu", ts.lsp_references, { desc = "LSP Usages (Telescope)", buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
	vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Code lens", buffer = bufnr })
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "LSP format", buffer = bufnr })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename symbol", buffer = bufnr })
end

-- Gutter symbols setup
vim.fn.sign_define(
	"DiagnosticSignError",
	{ text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "·", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "·", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })

-- Border setup
local border = {
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ " ", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- Spell check
local common_dictionary = {
	"Lang",
	"Ching",
	"Yeh",
}

require("lspconfig").ltex.setup({
	on_attach = on_attach,
	cmd = { "ltex-ls" },
	filetypes = { "text", "gitcommit" },
	settings = {
		ltex = {
			language = "auto",
			additionalRules = {
				motherTongue = "en-US",
			},
			trace = { server = "verbose" },
			dictionary = {
				["en-US"] = common_dictionary,
			},
		},
	},
	flags = { debounce_text_changes = 5000 },
	capabilities = capabilities,
})
-- JSON
require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- XML
require("lspconfig").lemminx.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- CSS
require("lspconfig").cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- Lua
require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
			formatting = {
				align_array_table = "none",
				align_function_params = false,
				align_continuous_assign_statement = false,
				align_continuous_rect_table_field = false,
				enable = true,
				indent = 2,
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
-- Rust
require("rust-tools").setup({
	server = {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-h>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})
-- Html, CSS, Javascript
require("lspconfig").html.setup({
	capabilities = capabilities,
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
	settings = {},
	single_file_support = true,
})
-- Typst
require("lspconfig").typst_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- Python
require("lspconfig").pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- C
require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- Markdown
require("lspconfig").marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- ASM
local util = require("lspconfig.util")
require("lspconfig").asm_lsp.setup({
	cmd = { "asm-lsp" },
	filetypes = { "asm", "vmasm" },
	root_dir = util.root_pattern("*.asm"),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Haskell
vim.g.haskell_tools = {
	tools = {
		hover = {
			border = border,
			stylize_markdown = true,
		},
	},
	hls = {
		on_attach = function(client, bufnr)
			local ht = require("haskell-tools")

			vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, { desc = "Hoogle signature", buffer = bufnr })
			vim.keymap.set("n", "<space>he", ht.lsp.buf_eval_all, { desc = "Evaluate all", buffer = bufnr })
			vim.keymap.set("n", "<space>hr", ht.repl.toggle, { desc = "Toggle repl" })

			vim.cmd("setlocal shiftwidth=2")
			on_attach(client, bufnr)
		end,
		default_settings = {
			haskell = {
				formattingProvider = "fourmolu",
			},
		},
	},
}
