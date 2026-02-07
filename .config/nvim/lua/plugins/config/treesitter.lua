require("nvim-treesitter.parsers").get_parser_configs().asm = {
	install_info = {
		url = "https://github.com/rush-rs/tree-sitter-asm.git",
		files = { "src/parser.c" },
		branch = "main",
	},
}

require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"bash",
		"c",
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"rust",
		"toml",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- set to `false` to disable one of the mappings
			-- init_selection = "false",
			-- scope_incremental = "false",
			-- node_incremental = "<A-Up>",
			-- node_decremental = "<A-Down>",
		},
	},
	refactor = {
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
	},
}
