local lsp_shared = require("plugins.config.lsp-shared")

vim.g.haskell_tools = {
	tools = {
		hover = {
			border = lsp_shared.border,
			stylize_markdown = true,
		},
	},
	hls = {
		on_attach = function(client, bufnr)
			local ht = require("haskell-tools")

			vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, { desc = "Hoogle signature", buffer = bufnr })
			vim.keymap.set("n", "<space>he", ht.lsp.buf_eval_all, { desc = "Evaluate all", buffer = bufnr })
			vim.keymap.set("n", "<space>hr", ht.repl.toggle, { desc = "Toggle repl" })

			vim.opt_local.shiftwidth = 2
			lsp_shared.on_attach(client, bufnr)
		end,
		default_settings = {
			haskell = {
				formattingProvider = "fourmolu",
			},
		},
	},
}
