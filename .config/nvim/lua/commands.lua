vim.api.nvim_create_user_command("UseLight", function()
	require("color-mode").UseLight()
end, {})

vim.api.nvim_create_user_command("UseDark", function()
	require("color-mode").UseDark()
end, {})

vim.api.nvim_create_user_command("ColorToggle", function()
	require("color-mode").ColorToggle()
end, {})
