local default_enable = require("dropbar.configs").opts.bar.enable

require("dropbar").setup({
	bar = {
		enable = function(buf, win, info)
			buf = vim._resolve_bufnr(buf)
			if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].filetype == "NvimTree" then
				return false
			end

			return default_enable(buf, win, info)
		end,
	},
})
