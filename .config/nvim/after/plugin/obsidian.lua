require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/documents/la-mente/",
		},
		{
			name = "lab",
			path = "~/desktop/lab",
		},
		{
			name = "2025 fall",
			path = "~/desktop/2025 fall",
		},
	},
	completion = {
		-- Set to false to disable completion.
		nvim_cmp = true,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "markdown", "markdown_inline" },
	highlight = {
		enable = true,
	},
})
