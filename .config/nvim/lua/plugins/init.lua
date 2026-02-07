local specs = {}

for _, module in ipairs({
	"plugins.ui",
	"plugins.lsp",
	"plugins.editing",
	"plugins.git",
	"plugins.telescope",
	"plugins.treesitter",
	"plugins.tools",
}) do
	vim.list_extend(specs, require(module))
end

return specs
