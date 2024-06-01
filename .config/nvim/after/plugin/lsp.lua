local map = vim.keymap.set
local def = vim.fn.sign_define


require("fidget").setup()
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {},
    automatic_installation = false,
}

map("n", "<space>e", vim.diagnostic.open_float, { desc = "LSP Float", noremap = true, silent = true })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", noremap = true, silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", noremap = true, silent = true })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Show LSP in list", noremap = true, silent = true })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- See `:help vim.lsp.*`
    local ts = require "telescope.builtin"

    map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufnr })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature help", buffer = bufnr })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
    map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
    map("n", "gtd", vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufnr })
    map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
    map("n", "gu", ts.lsp_references, { desc = "LSP Usages (Telescope)", buffer = bufnr })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
    map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Code lens", buffer = bufnr })
    map("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
    end, { desc = "LSP format", buffer = bufnr })
    map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename symbol", buffer = bufnr })
end

-- Gutter symbols setup
def("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
def("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
def("DiagnosticSignHint", { text = "·", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
def("DiagnosticSignInfo", { text = "·", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })

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
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)


require("lspconfig").ltex.setup {
    on_attach = on_attach,
    cmd = { "ltex-ls" },
    filetypes = { "text", "gitcommit" },
    settings = {
        ltex = {
            language = "auto",
            additionalRules = {
                motherTongue = "en-US",
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
require("lspconfig").jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- XML
require("lspconfig").lemminx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- CSS
require("lspconfig").cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Lua
require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            formatting = {
                align_array_table = "none",
                align_function_params = false,
                align_continuous_assign_statement = false,
                align_continuous_rect_table_field = false,
                enable = true,
                indent = 2,
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}
-- Html, CSS, Javascript
require("lspconfig").html.setup {
    capabilities = capabilities,
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
    settings = {},
    single_file_support = true,
}
-- Typst
require("lspconfig").typst_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Python
require("lspconfig").pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- C
require("lspconfig").clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Markdown
require("lspconfig").marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- ASM
local util = require "lspconfig.util"
require("lspconfig").asm_lsp.setup {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "vmasm" },
    root_dir = util.root_pattern "*.asm",
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Standalone plugins --

-- Haskell
vim.g.haskell_tools = {
    tools = {
        hover = {
            border = border,
            stylize_markdown = true,
        },
    },
    hls = {
        on_attach = function(client, bufnr)
            local ht = require "haskell-tools"

            vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, { desc = "Hoogle signature", buffer = bufnr })
            vim.keymap.set("n", "<space>he", ht.lsp.buf_eval_all, { desc = "Evaluate all", buffer = bufnr })
            vim.keymap.set("n", "<space>hr", ht.repl.toggle, { desc = "Toggle repl" })

            vim.cmd "setlocal shiftwidth=2"
            on_attach(client, bufnr)
        end,
        default_settings = {
            haskell = {
                formattingProvider = "fourmolu",
            },
        },
    },
}

-- Rust
vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
        settings = {},
    },
    tools = {
        hover = {
            border = border,
            stylize_markdown = true,
        },
        log = { level = vim.log.levels.OFF },
    },
}
