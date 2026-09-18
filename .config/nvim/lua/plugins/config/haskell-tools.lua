vim.g.haskell_tools = {
	tools = {
		hover = {
			stylize_markdown = true,
		},
	},
	hls = {
		on_attach = function(_, bufnr)
			local ht = require("haskell-tools")

			vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, { desc = "Hoogle signature", buffer = bufnr })
			vim.keymap.set("n", "<leader>he", ht.lsp.buf_eval_all, { desc = "Evaluate all", buffer = bufnr })
			vim.keymap.set("n", "<leader>hr", ht.repl.toggle, { desc = "Toggle repl", buffer = bufnr })

			vim.opt_local.shiftwidth = 2
		end,
		default_settings = {
			haskell = {
				formattingProvider = "fourmolu",
			},
		},
	},
}
