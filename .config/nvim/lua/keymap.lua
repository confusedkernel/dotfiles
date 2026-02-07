vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Move
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

map("n", "<leader>C", "<cmd>ColorToggle<CR>", { desc = "Toggle colorscheme", silent = true })

-- Tree
map("n", "<C-1>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })
