local session_dir = "~/Linguistics/courses/2026-spring/LING7007-fieldwork/glossing"
local export_dir = "~/Linguistics/courses/2026-spring/LING7007-fieldwork/glossing/export"

require("elicit").setup({
	session = {
		-- Use absolute paths for predictable testing
		dir = vim.fn.expand(session_dir),
		luasnip = {
			enable = true,
			trigger = "session",
			filetypes = { "markdown" },
		},
	},
	example = {
		luasnip = {
			enable = true,
			trigger = { "example" },
			filetypes = { "markdown" },
		},
	},
	search = {
		backend = "telescope", -- change to "quickfix" if you want no Telescope dependency
		corpus_glob = vim.fn.expand(session_dir) .. "/**/*.md",
	},
	export = {
		output_dir = vim.fn.expand(export_dir),
	},
})
-- Optional: Telescope integration (:Telescope elicit)
pcall(function()
	require("telescope").load_extension("elicit")
end)
