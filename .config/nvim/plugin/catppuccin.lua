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
            surface1 = "#fafafa",
        },
        frappe = {},
        macchiato = {},
        mocha = {},
    },
    integrations = {
        barbar = true,
    }
}
