local M = {}

function M.switchColorScheme(scheme)
	vim.cmd('colorscheme ' .. scheme)
end

function M.toggleColorScheme()
	local current_scheme = vim.fn.execute('colorscheme'):gsub('%s+', '')
	local target_scheme = (current_scheme == 'nordic') and 'catppuccin-latte' or 'nordic'
	M.switchColorScheme(target_scheme)
end

function M.UseLight()
	M.switchColorScheme('catppuccin-latte')
end

function M.UseDark()
	M.switchColorScheme('nordic')
end

function M.ColorToggle()
	M.toggleColorScheme()
end

vim.cmd('command! UseLight lua require("color-mode").UseLight()')
vim.cmd('command! UseDark lua require("color-mode").UseDark()')
vim.cmd('command! ColorToggle lua require("color-mode").ColorToggle()')

vim.api.nvim_set_keymap('n', '<leader>C', ':ColorToggle<CR>', { silent = true })

return M
