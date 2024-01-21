require("nordic").setup {
  theme = "nordic",
  bright_border = true,
  noice = {
    -- Available styles: `classic`, `flat`.
    style = "flat",
  },
}

vim.opt.background = "dark"
vim.cmd.colorscheme "nordic"
