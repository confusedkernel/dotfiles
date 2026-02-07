local M = {}

function M.config(name)
	return function()
		require("plugins.config." .. name)
	end
end

return M
