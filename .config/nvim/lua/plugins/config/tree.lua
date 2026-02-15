local api = vim.api
local color_utils = require("utils.color")

local function apply_tree_hl()
	local get_hl = api.nvim_get_hl
	local set_hl = api.nvim_set_hl

	local normal = get_hl(0, { name = "Normal", link = false })
	local normal_float = get_hl(0, { name = "NormalFloat", link = false })
	local visual = get_hl(0, { name = "Visual", link = false })
	local bg = normal_float.bg or normal.bg
	local cursorline_bg = visual.bg or color_utils.adjust_color(bg, vim.o.background == "dark" and 14 or -14)

	set_hl(0, "NvimTreeNormal", { bg = bg })
	set_hl(0, "NvimTreeNormalNC", { bg = bg })
	set_hl(0, "NvimTreeEndOfBuffer", { fg = bg, bg = bg })
	set_hl(0, "NvimTreeWinSeparator", { fg = bg, bg = bg })

	if cursorline_bg then
		set_hl(0, "NvimTreeCursorLine", { bg = cursorline_bg })
	end

	set_hl(0, "NvimTreeFolderName", { link = "Directory" })
	set_hl(0, "NvimTreeOpenedFolderName", { link = "Directory", bold = true })
	set_hl(0, "NvimTreeRootFolder", { link = "Title", bold = true })
	set_hl(0, "NvimTreeIndentMarker", { link = "Comment" })
	set_hl(0, "NvimTreeGitDirty", { link = "DiagnosticWarn" })
	set_hl(0, "NvimTreeGitNew", { link = "DiagnosticInfo" })
	set_hl(0, "NvimTreeGitDeleted", { link = "DiagnosticError" })
	set_hl(0, "NvimTreeSpecialFile", { link = "Special", underline = true })
end

local tree_group = api.nvim_create_augroup("TreeTheme", { clear = true })
api.nvim_create_autocmd("ColorScheme", {
	group = tree_group,
	callback = apply_tree_hl,
})

require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	git = {
		enable = true,
		ignore = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "·",
			info = "·",
			warning = "",
			error = "",
		},
	},
	renderer = {
		highlight_git = true,
		highlight_opened_files = "name",
		root_folder_label = ":~:s?$?/..?",
		indent_markers = {
			enable = true,
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
			},
			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = { "README.md", "Makefile", "makefile" },
	},
	view = {
		width = 30,
		signcolumn = "no",
		number = false,
		relativenumber = false,
	},
	filters = {
		custom = { "^\\.DS_Store$" },
	},
})

apply_tree_hl()
