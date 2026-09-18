local languages = {
	"bash",
	"c",
	"css",
	"diff",
	"fish",
	"gitcommit",
	"haskell",
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
	"tsx",
	"typescript",
	"typst",
	"vim",
	"vimdoc",
	"vue",
	"xml",
	"yaml",
}

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").asm = {
			install_info = {
				url = "https://github.com/rush-rs/tree-sitter-asm.git",
				branch = "main",
			},
		}
	end,
})

require("nvim-treesitter").setup()

-- Install any missing parsers off the startup path (already-installed ones are skipped).
vim.schedule(function()
	require("nvim-treesitter").install(languages)
end)

-- Start treesitter highlighting for any buffer whose filetype has a parser.
-- (Matching on filetype rather than parser name: e.g. bash's filetype is "sh".)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})
