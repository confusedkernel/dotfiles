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
	ui = {
		enable = false,
	},
	-- Sets how you follow URLs
	---@param url string
	follow_url_func = function(url)
		vim.ui.open(url)
		-- vim.ui.open(url, { cmd = { "firefox" } })
	end,

	-- Sets how you follow images
	---@param img string
	follow_img_func = function(img)
		vim.ui.open(img)
		-- vim.ui.open(img, { cmd = { "loupe" } })
	end,
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "markdown", "markdown_inline" },
	highlight = {
		enable = true,
	},
})
