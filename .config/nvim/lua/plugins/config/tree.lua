require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
	hijack_unnamed_buffer_when_opening = false,
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	view = {
		width = 35,
	},
})
