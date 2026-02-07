local lsp_shared = require("plugins.config.lsp-shared")

vim.g.rustaceanvim = {
	server = {
		on_attach = lsp_shared.on_attach,
		settings = {
			hints = {
				enable = true,
			},
		},
	},
	tools = {
		hover = {
			border = lsp_shared.border,
			stylize_markdown = true,
		},
		log = { level = vim.log.levels.OFF },
	},
}
