require("render-markdown").setup({
	checkbox = {
		custom = {
			important = { raw = "[!]", rendered = "", highlight = "RenderMarkdownWarn", scope_highlight = "" },
			tilde = { raw = "[~]", rendered = "󰰱", highlight = "RenderMarkdownError", scope_highlight = "" },
			rightArr = { raw = "[>]", rendered = "", highlight = "RenderMarkdownTodo", scope_highlight = "" },
		},
	},
})
