require("catppuccin").setup {
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        tags = { "underline" },
        loops = {},
        functions = { "italic" },
        keywords = { "underline" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {
        latte = {
            base = "#fafafa",
            mantle = "#e6e6e6",
            crust = "#dcdcdc",
        },
        frappe = {},
        macchiato = {},
        mocha = {},
    },
    highlight_overrides = {
        latte = function(latte)
            return {
                BufferCurrent = { bg = "#fafafa", fg = C.text },
                BufferCurrentIndex = { bg = "#fafafa", fg = C.blue },
                BufferCurrentMod = { bg = "#fafafa", fg = C.yellow },
                BufferCurrentSign = { bg = "#fafafa", fg = C.blue },
                BufferCurrentTarget = { bg = "#fafafa", fg = C.red },
            }
        end
    },
    integrations = {
        barbar = true,
        harpoon = true,
        telescope = {
            enabled = true,
            style = "nvchad",
        },
        noice = {
            enabled = true,
            style = "nvchad"
        },
        notify = true,

    },
}

vim.opt.background = "light"
vim.cmd.colorscheme("catppuccin")
