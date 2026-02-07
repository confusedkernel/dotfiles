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
		-- borderchars = { "", "", "", "│", "", "", "", "" },
		-- layout_config = { height = 0.6 },
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
			borderchars = borderchars,
			layout_config = { height = 0.7 },
		},
		live_grep = {
			theme = "ivy",
			borderchars = borderchars,
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

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
		borderchars = borderchars,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch All [F]iles" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
