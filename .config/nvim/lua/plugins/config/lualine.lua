-- Show git status.
local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
	end
end

--------------------------------------------------------------------------------

local function get_current_filetype()
	return vim.bo[0].filetype
end

local function get_current_buftype()
	return vim.bo[0].buftype
end

-- Get the buffer's filename.
local function get_current_filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	return bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
end

--------------------------------------------------------------------------------

-- Gets the current buffer's filename with the filetype icon supplied
-- by devicons.
local M = require("lualine.components.filetype"):extend()
local Icon_hl_cache = {}
local lualine_require = require("lualine_require")
local modules = lualine_require.lazy_require({
	highlight = "lualine.highlight",
	utils = "lualine.utils.utils",
})

--------------------------------------------------------------------------------

function M:get_current_filetype_icon()
	-- Get setup.
	local icon, icon_highlight_group
	local _, devicons = pcall(require, "nvim-web-devicons")
	local f_name, f_extension = vim.fn.expand("%:t"), vim.fn.expand("%:e")
	f_extension = f_extension ~= "" and f_extension or vim.bo.filetype
	icon, icon_highlight_group = devicons.get_icon(f_name, f_extension)

	-- Fallback settings.
	if icon == nil and icon_highlight_group == nil then
		icon = ""
		icon_highlight_group = "DevIconDefault"
	end

	-- Set colors.
	local highlight_color = modules.utils.extract_highlight_colors(icon_highlight_group, "fg")
	if highlight_color then
		local icon_highlight = Icon_hl_cache[highlight_color]
		if not icon_highlight or not modules.highlight.highlight_exists(icon_highlight.name .. "_normal") then
			icon_highlight = self:create_hl({ fg = highlight_color }, icon_highlight_group)
			Icon_hl_cache[highlight_color] = icon_highlight
		end
	end

	-- Return the formatted string.
	return icon
end

function M:get_current_filename_with_icon()
	local suffix = ""

	-- Get icon and filename.
	local icon = M.get_current_filetype_icon(self)
	local f_name = get_current_filename()

	if vim.bo.ft == "nvdash" then
		f_name = "Dashboard"
		icon = "󰋞"
	elseif vim.bo.ft == "TelescopePrompt" then
		f_name = "Telescope"
		icon = "󰭎"
	end

	local readonly = vim.bo[0].readonly
	local modifiable = vim.bo[0].modifiable
	local nofile = get_current_buftype() == "nofile"
	if readonly or nofile or not modifiable then
		suffix = " "
	end

	-- Return the formatted string.
	return icon .. " " .. f_name .. suffix
end

local function get_native_lsp()
	local buf_ft = get_current_filetype()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) == nil then
		return ""
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "copilot" then
			return client.name
		end
	end
	return ""
end

--------------------------------------------------------------------------------

local function get_short_cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

local tree = {
	sections = {
		lualine_a = {
			{
				"mode",
				icon = { "" },
				separator = { right = "", left = "" },
			},
		},
		lualine_b = {
			{
				get_short_cwd,
				padding = 1,
				icon = { " " },
			},
		},
		lualine_c = {},
		lualine_z = {
			{
				"progress",
				icon = { "", align = "left" },
				separator = { right = "", left = "" },
			},
		},
	},
	filetypes = { "NvimTree" },
}

--------------------------------------------------------------------------------

require("lualine").setup({
	options = {
		globalstatus = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icon = { "" },
				separator = { right = "", left = "" },
			},
		},
		lualine_b = {
			{
				M.get_current_filename_with_icon,
			},
		},
		lualine_c = {
			{
				"branch",
				icon = { " " },
				separator = " ",
				padding = 0,
			},
			{
				"diff",
				padding = 1,
				source = diff_source,
				symbols = { added = " ", modified = " ", removed = " " },
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = "󱤅 ", other = "󰠠 " },
				colored = true,
				padding = 1,
			},
		},
		lualine_y = {
			{
				get_native_lsp,
				padding = 1,
				separator = " ",
				icon = { " " },
			},
		},
		lualine_z = {
			{
				"progress",
				icon = { "", align = "left" },
				separator = { right = "", left = "" },
			},
		},
	},

	extensions = { ["nvim-tree"] = tree },
})

