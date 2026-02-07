require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_installation = false,
	automatic_enable = false,
})

local lsp_shared = require("plugins.config.lsp-shared")

local on_attach = lsp_shared.on_attach
local border = lsp_shared.border

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
			semanticTokens = "disable",
		},
	},
}

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = border,
	},
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

	if vim.lsp and vim.lsp.config and vim.lsp.enable then
		vim.lsp.config(name, server_config)
		vim.lsp.enable(name)
	else
		require("lspconfig")[name].setup(server_config)
	end
end

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
