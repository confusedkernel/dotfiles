require("barbar").setup({
	-- Open/close/move animations make every buffer change take ~150ms to settle.
	animation = false,
	tabpages = false,
	auto_hide = true,
	clickable = true,
	sidebar_filetypes = {
		NvimTree = { text = "Everything Bagel", align = "center" },
		UndoTree = { text = "UndoTree" },
	},
	preset = "default",
	exclude_ft = { "", "NvimTree" },
	no_name_title = nil,
	separator = { left = "▎", right = "" },
})
