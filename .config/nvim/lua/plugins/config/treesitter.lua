local languages = {
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
require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
