require("fidget").setup({
    text = {
        spinner = "dots",
        -- done = "[Ok]",
    },
})

require "mason".setup()
require "mason-lspconfig".setup {
    ensure_installed = {},
    automatic_installation = false
}
require "neodev".setup()

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*`
    local ts = require "telescope.builtin"

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufnr })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP Signature help", buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufnr })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
    vim.keymap.set('n', 'gu', ts.lsp_references, { desc = "LSP Usages (Telescope)", buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { desc = "Code lens", buffer = bufnr })
    vim.keymap.set('n', '<leader>f',
        function() vim.lsp.buf.format { async = true } end,
        { desc = "LSP format", buffer = bufnr }
    )
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = "LSP Rename symbol", buffer = bufnr })
end

-- Gutter symbols setup
vim.fn.sign_define("DiagnosticSignError", { text = '', texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = '', texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = '·', texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = '·', texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })


-- Border setup
local border = {
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require "cmp_nvim_lsp".default_capabilities(capabilities)
-- Spell check
local common_dictionary = {
    "Lang", "Ching", "Yeh"
}

require "lspconfig".ltex.setup {
    on_attach = on_attach,
    cmd = { "ltex-ls" },
    filetypes = { "markdown", "text", "gitcommit" },
    settings = {
        ltex = {
            language = "auto",
            additionalRules = {
                motherTongue = "en-US"
            },
            trace = { server = "verbose" },
            dictionary = {
                ["en-US"] = common_dictionary,
            },
        },
    },
    flags = { debounce_text_changes = 5000 },
    capabilities = capabilities,
}
-- JSON
require "lspconfig".jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- XML
require "lspconfig".lemminx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- CSS
require "lspconfig".cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Lua
require "lspconfig".lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        lua = {
            formatting = {
                enable = true,
                indent = 2,
            },
            diagnostics = {
                globals = { 'vim' },
            },
        }
    },
}
-- Rust
require "lspconfig".rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Scala
require "lspconfig".metals.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Golang
require "lspconfig".gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Python
require "lspconfig".pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- C
require "lspconfig".clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--local null_ls = require("null-ls")

--null_ls.setup({
--    sources = {
--        null_ls.builtins.formatting.stylua,
--        null_ls.builtins.diagnostics.eslint,
--        null_ls.builtins.completion.spell,
--        null_ls.
--    },
--})
