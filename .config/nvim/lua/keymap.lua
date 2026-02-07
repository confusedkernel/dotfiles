vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Core Editing
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", ">", ">gv", { desc = "Indent to right" })
map("v", "<", "<gv", { desc = "Indent to left" })
map("v", "=", "=gv", { desc = "Reindent selection" })

-- Centered Motions
map("n", "<C-d>", "<C-d>zz", { desc = "Move page down with cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move page up with cursor centered" })
map("n", "n", "nzzzv", { desc = "Find next with cursor centered" })
map("n", "N", "Nzzzv", { desc = "Find last with cursor centered" })

-- Join line below
map("n", "J", "mzJ`z", { desc = "Join line below without moving cursor" })

-- Clipboard system
map({ "n", "x", "v" }, "<leader>d", '"_d', { desc = "Delete without cutting" })
map({ "n", "x", "v" }, "<leader>c", '"_dc', { desc = "Change without cutting" })
map({ "n", "x", "v" }, "<leader>p", '"_dP', { desc = "Paste without copying selected" })
map({ "n", "x", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })

map("n", "Q", "<nop>", { desc = "It's the worse place in the universe" })

map("n", "<leader>nf", function()
	vim.cmd("enew")
end, { desc = "Open new buffer" })

map("c", "#lm", [[\{-}]], { desc = "[L]azy [M]atch" })
map("c", "#capl", [[\(.\{-}\)]], { desc = "[CAP]ture [L]ess" })
map("c", "#capm", [[\(.*\)]], { desc = "[CAP]ture [M]ore" })

map("n", "j", "gj", { desc = "Down by display line" })
map("n", "k", "gk", { desc = "Up by display line" })
map("n", "<Down>", "g<Down>", { desc = "Down by display line" })
map("n", "<Up>", "g<Up>", { desc = "Up by display line" })

map("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap locally", silent = true })

-- Colorscheme (color-mode plugin helper)
map("n", "<leader>C", "<cmd>ColorToggle<CR>", { desc = "Toggle colorscheme", silent = true })

-- LSP plugin
map("n", "<space>e", vim.diagnostic.open_float, { desc = "LSP float", silent = true })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", silent = true })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Show diagnostics in list", silent = true })

-- NvimTree plugin
map("n", "<C-1>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })

-- Telescope plugin
map("n", "<leader>?", "<cmd>Telescope oldfiles<CR>", { desc = "[?] Find recently opened files", silent = true })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<CR>", { desc = "[/] Fuzzily search in current buffer", silent = true })
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch all [F]iles", silent = true })
map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "Search [G]it [F]iles", silent = true })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp", silent = true })
map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "[S]earch current [W]ord", silent = true })
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep", silent = true })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics", silent = true })

-- Barbar plugin
map("n", "<A-[>", "<cmd>BufferPrevious<CR>", { desc = "Barbar previous buffer", silent = true })
map("n", "<A-]>", "<cmd>BufferNext<CR>", { desc = "Barbar next buffer", silent = true })
map("n", "<C-{>", "<cmd>BufferMovePrevious<CR>", { desc = "Barbar move buffer left", silent = true })
map("n", "<C-}>", "<cmd>BufferMoveNext<CR>", { desc = "Barbar move buffer right", silent = true })
map("n", "<A-P>", "<cmd>BufferPin<CR>", { desc = "Barbar pin buffer", silent = true })
map("n", "<A-C>", "<cmd>BufferClose<CR>", { desc = "Barbar close buffer", silent = true })

-- Undotree plugin
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree", silent = true })

-- Fugitive plugin
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "[G]it [S]tatus", silent = true })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Open fugitive blame", silent = true })
map("n", "<leader><space>", function()
	vim.cmd("Git")
	vim.cmd("normal! 5j")
end, { desc = "Open fugitive status", silent = true })

local fugitive_group = augroup("FugitiveKeymaps", { clear = true })
autocmd("FileType", {
	group = fugitive_group,
	pattern = "fugitive",
	callback = function()
		map("n", "<leader><space>", "<cmd>q<CR>", { desc = "Close fugitive status", buffer = true, silent = true })
	end,
})

autocmd("FileType", {
	group = fugitive_group,
	pattern = "fugitiveblame",
	callback = function()
		map("n", "<leader>gb", "<cmd>q<CR>", { desc = "Close fugitive blame", buffer = true, silent = true })
	end,
})
