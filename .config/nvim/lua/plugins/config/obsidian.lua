require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/documents/la-mente/",
		},
		{
			name = "linguistics",
			path = "~/linguistics/",
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
	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
		name = "telescope.nvim",
		-- Optional, configure key mappings for the picker. These are the defaults.
		-- Not all pickers support all mappings.
		note_mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-l>",
		},
		tag_mappings = {
			-- Add tag(s) to current note.
			tag_note = "<C-x>",
			-- Insert a tag at the current location.
			insert_tag = "<C-l>",
		},
	},

	-- Sets how you follow URLs
	---@param url string
	follow_url_func = function(url)
		vim.ui.open(url)
	end,

	---@param img string
	follow_img_func = function(img)
		vim.ui.open(img)
	end,
})
