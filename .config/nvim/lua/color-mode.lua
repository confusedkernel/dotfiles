local M = {}

M.dark_scheme = "nordic"
M.light_scheme = "catppuccin-latte"

function M.switchColorScheme(scheme)
	vim.cmd.colorscheme(scheme)
end

function M.UseLight()
	M.switchColorScheme(M.light_scheme)
end

function M.UseDark()
	M.switchColorScheme(M.dark_scheme)
end

function M.ColorToggle()
	local current_scheme = vim.g.colors_name or ""
	local target_scheme = (current_scheme == M.dark_scheme) and M.light_scheme or M.dark_scheme
	M.switchColorScheme(target_scheme)
end

return M
