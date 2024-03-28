vim.opt.termguicolors = true

require("nvim-tree").setup(
  vim.api.nvim_set_keymap("n", "<C-1>", ":NvimTreeToggle<CR>", { desc = "NvimTree", noremap = true, silent = true })
)
