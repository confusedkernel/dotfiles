vim.opt.termguicolors = true
local bufferline = require('bufferline')

bufferline.setup {
    options = {
        mode = "buffers",
        themeable = true,
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        style_preset = {
            bufferline.style_preset.no_italic,
        }
    }
}
