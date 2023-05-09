require("nvim-tree").setup(
    vim.api.nvim_set_keymap('n', '<C-1>', ':NvimTreeToggle<CR>', { noremap = true })
)
