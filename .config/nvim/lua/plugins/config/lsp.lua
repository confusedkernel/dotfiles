----------------------
-- Language Servers --
----------------------
-- Defaults (cmd, filetypes, root markers) come from nvim-lspconfig's lsp/*.lua.
-- Only overrides go here. Binaries come from Mason (see lua/options.lua for PATH)
-- or Homebrew. Buffer keymaps live in the LspAttach autocmd in lua/autocmds.lua.

local vue_ts_plugin = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local servers = {
	clangd = {}, -- C, C++
	cssls = {}, -- CSS
	jsonls = {}, -- JSON
	lemminx = {}, -- XML
	pylsp = {}, -- Python
	marksman = {}, -- Markdown
	html = {}, -- HTML
	lua_ls = {
		settings = {
			Lua = {
				hint = { enable = true },
				workspace = { checkThirdParty = false },
				diagnostics = { globals = { "vim" } },
			},
		},
	},
	-- Vue 3 runs in "hybrid mode": vue_ls handles the template/style parts and
	-- forwards TypeScript requests to ts_ls, which needs the Vue TS plugin.
	ts_ls = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		init_options = {
			plugins = {
				{ name = "@vue/typescript-plugin", location = vue_ts_plugin, languages = { "vue" } },
			},
		},
	},
	vue_ls = {},
	tinymist = {
		on_attach = function(client, bufnr)
			local function pin(path)
				client:request("workspace/executeCommand", {
					command = "tinymist.pinMain",
					arguments = { path },
				}, nil, bufnr)
			end
			vim.keymap.set("n", "<leader>tp", function()
				pin(vim.api.nvim_buf_get_name(bufnr))
			end, { buffer = bufnr, desc = "[T]inymist [P]in" })
			vim.keymap.set("n", "<leader>tu", function()
				pin(vim.v.null)
			end, { buffer = bufnr, desc = "[T]inymist [U]npin" })
		end,
		root_dir = function(bufnr, on_dir)
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local root = vim.fs.root(bufnr, { ".git" }) or (bufname ~= "" and vim.fs.dirname(bufname)) or vim.uv.cwd()
			on_dir(root)
		end,
		settings = {
			formatterMode = "typstyle",
			semanticTokens = "disable",
		},
	},
}

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "·",
			[vim.diagnostic.severity.INFO] = "·",
		},
	},
})

-- Completion capabilities advertised to every server. This mirrors what
-- require("blink.cmp").get_lsp_capabilities() returns, declared statically so
-- opening a file doesn't load blink.cmp (and LuaSnip) before insert mode.
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
					commitCharactersSupport = false,
					documentationFormat = { "markdown", "plaintext" },
					deprecatedSupport = true,
					preselectSupport = false,
					tagSupport = { valueSet = { 1 } },
					insertReplaceSupport = true,
					resolveSupport = {
						properties = { "documentation", "detail", "additionalTextEdits", "command", "data" },
					},
					insertTextModeSupport = { valueSet = { 1 } },
					labelDetailsSupport = true,
				},
				completionList = {
					itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
				},
				contextSupport = true,
				insertTextMode = 1,
			},
		},
	},
})

for name, config in pairs(servers) do
	if next(config) ~= nil then
		vim.lsp.config(name, config)
	end
end

vim.lsp.enable(vim.tbl_keys(servers))
