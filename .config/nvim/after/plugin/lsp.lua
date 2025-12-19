require("fidget").setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_installation = false,
	automatic_enable = false,
})

local map = vim.keymap.set
local util = require("lspconfig.util")
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
		on_attach = function(_, bufno)
			map("n", "<leader>f", function()
				vim.cmd(":w")
				vim.cmd([[silent exec "!stylua %"]])
				vim.cmd(":e")
			end, { buffer = bufno })
		end,
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
		on_attach = function(_, bufno)
			map("n", "<leader>f", function()
				vim.cmd(":w")
				vim.cmd([[silent exec "!npx prettier --write %"]])
				vim.cmd(":e")
			end, { buffer = bufno })
		end,
		filetypes = { "typescript", "javascript", "vue" },
		on_new_config = function(new_config, new_root_dir)
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
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufno })

local on_attach = function(_, bufno)
	vim.api.nvim_buf_set_option(bufno, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Enable inlay hints
	vim.lsp.inlay_hint.enable()

	-- See `:help vim.lsp.*`
	local ts = require("telescope.builtin")

	map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufno })
	map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature help", buffer = bufno })
	map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufno })
	map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufno })
	map("n", "gtd", vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufno })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufno })
	map("n", "gu", ts.lsp_references, { desc = "LSP Usages (Telescope)", buffer = bufno })
	map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action", buffer = bufno })
	map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Code lens", buffer = bufno })
	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "LSP format", buffer = bufno })
	map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename symbol", buffer = bufno })

	-- LSP Inlay Hints
	--if vim.lsp.inlay_hint then
	map("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}), {})
	end, { desc = "Toggle Inlay Hints" })
	--end
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

local settings = {
	hints = {
		enable = true,
	},
}

for name, config in pairs(servers) do
	require("lspconfig")[name].setup({
		capabilities = capabilities,
		settings = (config.settings or settings),
		on_attach = function(client, bufno)
			-- Call the config.on_attach function if it exists
			on_attach(client, bufno);
			(config.on_attach or function(...) end)(client, bufno)
		end,
	})
end

------------------------
-- Standalone plugins --
------------------------

vim.cmd([[
    let g:neoformat_basic_format_retab = 1
    let g:neoformat_try_node_exe = 1
    ]])
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

-- Set up an autocmd to format files before saving
vim.api.nvim_create_autocmd("BufWritePre", {
	group = fmt_group,
	pattern = "*",
	command = "undojoin | Neoformat",
})
vim.g.neoformat_try_node_exe = 1

-- Pin Buffer to Avoid Tinymist Reference Error
vim.api.nvim_create_user_command("TypstPin", function()
	local tinymist_id = nil
	for _, client in pairs(vim.lsp.get_active_clients()) do
		if client.name == "tinymist" then
			tinymist_id = client.id
			break
		end
	end

	if not tinymist_id then
		vim.notify("tinymist not running!", vim.log.levels.ERROR)
		return
	end

	local client = vim.lsp.get_client_by_id(tinymist_id)
	if client then
		client.request("workspace/executeCommand", {
			command = "tinymist.pinMain",
			arguments = { vim.api.nvim_buf_get_name(0) },
		}, function(err)
			if err then
				vim.notify("error pinning: " .. err, vim.log.levels.ERROR)
			else
				vim.notify("succesfully pinned", vim.log.levels.INFO)
			end
		end, 0)
	end
end, {})
