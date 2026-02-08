local M = {}

M.dark_scheme = "nordic"
M.light_scheme = "catppuccin-latte"

local function background_for_scheme(scheme)
	if scheme == M.dark_scheme then
		return "dark"
	end
	return "light"
end

function M.IsSystemDark()
	if vim.uv.os_uname().sysname ~= "Darwin" then
		return vim.o.background == "dark"
	end

	local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
	if vim.v.shell_error ~= 0 then
		return false
	end

	return output:match("Dark") ~= nil
end

function M.switchColorScheme(scheme)
	vim.o.background = background_for_scheme(scheme)
	vim.cmd.colorscheme(scheme)
end

function M.UseLight()
	M.switchColorScheme(M.light_scheme)
end

function M.UseDark()
	M.switchColorScheme(M.dark_scheme)
end

function M.ApplySystemTheme()
	if M.IsSystemDark() then
		M.UseDark()
		return
	end

	M.UseLight()
end

function M.ColorToggle()
	local current_scheme = vim.g.colors_name or ""
	local target_scheme = (current_scheme == M.dark_scheme) and M.light_scheme or M.dark_scheme
	M.switchColorScheme(target_scheme)
end

return M
