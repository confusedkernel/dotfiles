require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_installation = false,
	automatic_enable = false,
})

local map = vim.keymap.set

local function lsp_references_picker()
	local ok, telescope_builtin = pcall(require, "telescope.builtin")
	if ok then
		telescope_builtin.lsp_references()
		return
	end

	vim.lsp.buf.references()
end

local function get_typescript_server_path(root_dir)
	local project_ts = vim.fs.joinpath(root_dir, "node_modules", "typescript", "lib")
	if (vim.uv or vim.loop).fs_stat(project_ts) then
		return project_ts
	end

	return vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib"
end

----------------------
-- Language Servers --
----------------------

local servers = {
	clangd = {}, -- C, C++
	cssls = {}, -- CSS
	jsonls = {}, -- JSON
	lemminx = {}, -- XML
	pylsp = {}, -- Python
	marksman = {}, -- Markdown
	lua_ls = {
		settings = {
			hint = {
				enable = true,
			},
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
	},
	html = {
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
	},
	volar = {
		filetypes = { "typescript", "javascript", "vue" },
		on_new_config = function(new_config, new_root_dir)
			new_config.init_options = new_config.init_options or {}
			new_config.init_options.typescript = new_config.init_options.typescript or {}
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end,
	},
	tinymist = {
		root_dir = function(_, bufnr)
			return vim.fs.root(bufnr, { ".git" }) or vim.fn.expand("%:p:h")
		end,
		settings = {
			formatterMode = "typstyle",
			-- exportPdf = "onSave",
			semanticTokens = "disable",
		},
	},
}

map("n", "<space>e", vim.diagnostic.open_float, { desc = "LSP Float", noremap = true, silent = true })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", noremap = true, silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", noremap = true, silent = true })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Show LSP in list", noremap = true, silent = true })

local on_attach = function(client, bufno)
	vim.api.nvim_buf_set_option(bufno, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufno })
	end

	map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufno })
	map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature help", buffer = bufno })
	map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufno })
	map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufno })
	map("n", "gtd", vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufno })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufno })
	map("n", "gu", lsp_references_picker, { desc = "LSP Usages", buffer = bufno })
	map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action", buffer = bufno })
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

-- Diagnostic display configuration
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "·",
			[vim.diagnostic.severity.INFO] = "·",
		},
	},
})

-- Language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for name, config in pairs(servers) do
	local server_config = vim.tbl_deep_extend("force", {}, config, {
		capabilities = capabilities,
	})

	local server_on_attach = server_config.on_attach
	server_config.on_attach = function(client, bufno)
		on_attach(client, bufno)
		if server_on_attach then
			server_on_attach(client, bufno)
		end
	end

	require("lspconfig")[name].setup(server_config)
end

------------------------
-- Standalone plugins --
------------------------

vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_try_node_exe = 1
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

-- Rust
vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach,
		settings = {
			hints = {
				enable = true,
			},
		},
	},
	tools = {
		hover = {
			border = border,
			stylize_markdown = true,
		},
		log = { level = vim.log.levels.OFF },
	},
}

---------------
-- Neoformat --
---------------

-- Create an augroup for formatting
local fmt_group = vim.api.nvim_create_augroup("fmt", { clear = true })

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

-- Set up an autocmd to format files before saving
vim.api.nvim_create_autocmd("BufWritePre", {
	group = fmt_group,
	pattern = "*",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if not neoformat_filetypes[ft] then
			return
		end

		vim.cmd("silent! undojoin | Neoformat")
	end,
})

-- Pin Buffer to Avoid Tinymist Reference Error
vim.api.nvim_create_user_command("TypstPin", function()
	local client = vim.lsp.get_clients({ name = "tinymist" })[1]
	if not client then
		vim.notify("tinymist not running!", vim.log.levels.ERROR)
		return
	end

	client.request("workspace/executeCommand", {
		command = "tinymist.pinMain",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}, function(err)
		if err then
			local msg = err.message or tostring(err)
			vim.notify("error pinning: " .. msg, vim.log.levels.ERROR)
		else
			vim.notify("successfully pinned", vim.log.levels.INFO)
		end
	end, 0)
end, {})
