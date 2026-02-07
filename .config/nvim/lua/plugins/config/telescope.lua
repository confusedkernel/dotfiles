local actions = require("telescope.actions")
local telescope = require("telescope")

local borderchars = {
	prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
	results = { " ", " ", " ", " ", " ", " ", " ", " " },
	preview = { " ", " ", " ", " ", " ", " ", " ", " " },
}

telescope.setup({
	-- universal theme settings
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		borderchars = borderchars,
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},

	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			layout_config = { height = 0.7 },
		},
		lsp_references = {
			theme = "ivy",
			layout_config = { height = 0.7 },
		},
		live_grep = {
			theme = "ivy",
			layout_config = { height = 0.7 },
		},
	},

	on_enter = function()
		vim.cmd("doautocmd CursorMoved")
		vim.cmd("doautocmd CursorMovedI")
	end,
})

for _, extension in ipairs({ "fzf", "file_browser", "undo" }) do
	pcall(telescope.load_extension, extension)
end
