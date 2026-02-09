local cmp = require("cmp")
local luasnip = require("luasnip")
local color_utils = require("utils.color")

local cmp_ui = {
	style = "atom", -- default | atom | atom_colored
	icons_left = true,
	abbr_maxwidth = 45,
}

local icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰆧",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󱓻",
	File = "󰈚",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
}

local atom_styled = cmp_ui.style == "atom" or cmp_ui.style == "atom_colored"
local fields = (atom_styled or cmp_ui.icons_left) and { "kind", "abbr", "menu" } or { "abbr", "kind", "menu" }

local has_words_before = function()
	local unpack_fn = table.unpack or unpack
	local line, col = unpack_fn(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_group = vim.api.nvim_create_augroup("CmpNvchadTheme", { clear = true })

local function apply_cmp_hl()
	local set_hl = vim.api.nvim_set_hl
	local get_hl = vim.api.nvim_get_hl

	local pmenu_hl = get_hl(0, { name = "Pmenu", link = false })
	local visual_hl = get_hl(0, { name = "Visual", link = false })
	local delta = vim.o.background == "dark" and 18 or -18
	local sel_bg = visual_hl.bg or color_utils.adjust_color(pmenu_hl.bg, delta)

	set_hl(0, "CmpPmenu", { link = "Pmenu" })
	if sel_bg then
		set_hl(0, "CmpSel", { bg = sel_bg, fg = pmenu_hl.fg, bold = true })
	else
		set_hl(0, "CmpSel", { link = "PmenuSel" })
	end

	local pmenu_bg = pmenu_hl.bg
	if pmenu_bg then
		set_hl(0, "CmpBorder", { fg = pmenu_bg, bg = pmenu_bg })
	else
		set_hl(0, "CmpBorder", { link = "Pmenu" })
	end

	set_hl(0, "CmpDoc", { link = "NormalFloat" })

	local doc_hl = get_hl(0, { name = "CmpDoc", link = false })
	if doc_hl.bg then
		set_hl(0, "CmpDocBorder", { fg = doc_hl.bg, bg = doc_hl.bg })
	else
		set_hl(0, "CmpDocBorder", { link = "NormalFloat" })
	end

	set_hl(0, "CmpItemAbbr", { link = "Normal" })
	set_hl(0, "CmpItemAbbrMatch", { link = "Search", bold = true })
	set_hl(0, "CmpItemMenu", { link = "Comment" })

	set_hl(0, "CmpItemKindFunction", { link = "Function" })
	set_hl(0, "CmpItemKindMethod", { link = "Function" })
	set_hl(0, "CmpItemKindVariable", { link = "Identifier" })
	set_hl(0, "CmpItemKindClass", { link = "Type" })
	set_hl(0, "CmpItemKindKeyword", { link = "Keyword" })
	set_hl(0, "CmpItemKindString", { link = "String" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = cmp_group,
	callback = apply_cmp_hl,
})

apply_cmp_hl()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = fields,
		format = function(_, item)
			local icon = icons[item.kind] or ""
			local kind = item.kind or ""

			if atom_styled then
				item.menu = kind
				item.menu_hl_group = "LineNr"
				item.kind = " " .. icon .. " "
			elseif cmp_ui.icons_left then
				item.menu = kind
				item.menu_hl_group = "CmpItemKind" .. kind
				item.kind = icon
			else
				item.kind = " " .. icon .. " " .. kind
				item.menu_hl_group = "Comment"
			end

			if #item.abbr > cmp_ui.abbr_maxwidth then
				item.abbr = item.abbr:sub(1, cmp_ui.abbr_maxwidth) .. "…"
			end

			return item
		end,
	},
	window = {
		completion = {
			scrollbar = false,
			side_padding = atom_styled and 0 or 1,
			winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
			border = atom_styled and "none" or "single",
		},
		documentation = {
			border = "single",
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})
