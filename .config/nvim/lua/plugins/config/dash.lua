require("nvchad_ui").setup({
	lazyVim = true,
	statusline = { enabled = false },
	tabufline = { enabled = false },
	theme_toggle = { enabled = false },
	nvdash = {
		load_on_startup = true,
		buttons = {
			{ "  Find File", "f", "Telescope find_files" },
			{ "  Recent Files", "r", "Telescope oldfiles" },
			{ "  Find Word", "g", "Telescope live_grep" },
			{ "  Telescope", "t", "Telescope" },
			{ "󰒲  Lazy", "l", "Lazy" },
			{ "  Quit", "q", "qa" },
		},
	},
})
