local vscode_loader = require("luasnip.loaders.from_vscode")

vscode_loader.lazy_load()

local snippet_path = vim.fn.stdpath("config") .. "/snippets"
if vim.uv.fs_stat(snippet_path) then
	vscode_loader.lazy_load({ paths = { snippet_path } })
end
