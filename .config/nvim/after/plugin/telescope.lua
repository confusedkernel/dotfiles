local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		borderchars = {
			prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
			results = { " ", " ", " ", " ", " ", " ", " ", " " },
			preview = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
	},

	on_enter = function()
		vim.cmd("doautocmd CursorMoved")
		vim.cmd("doautocmd CursorMovedI")
	end,
})

-- Enable telescope fzf native, if installed
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("undo")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search [A]ll [F]iles" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
