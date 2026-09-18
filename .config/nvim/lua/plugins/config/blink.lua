local icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰆧",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󱓻",
	File = "󰈚",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
}

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "snippets", "path" },
	},
	keymap = {
		preset = "none",
		["<CR>"] = { "accept", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-d>"] = { "scroll_documentation_up", "fallback" },
		["<C-u>"] = { "scroll_documentation_down", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "show", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
	},
	completion = {
		list = {
			selection = { preselect = true, auto_insert = false },
		},
		menu = {
			border = "none",
			scrollbar = false,
			draw = {
				padding = { 0, 1 },
				columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
				components = {
					kind_icon = {
						text = function(ctx)
							return " " .. (icons[ctx.kind] or ctx.kind_icon) .. " "
						end,
					},
					kind = {
						highlight = "LineNr",
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "single" },
		},
	},
	appearance = {
		kind_icons = icons,
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
