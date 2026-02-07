vim.g.barbar_auto_setup = false

require("barbar").setup({
	custom_colors = true,
	animation = true,
	tabpages = false,
	auto_hide = true,
	clickable = true,
	sidebar_filetypes = {
		NvimTree = { text = "Everything Bagel", align = "center" },
		UndoTree = { text = "UndoTree" },
	},
	preset = "default",
	exclude_ft = { "" },
	no_name_title = nil,
	separator = { left = "▎", right = "" },
})
