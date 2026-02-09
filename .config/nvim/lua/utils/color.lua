local M = {}

function M.adjust_color(color, delta)
	if type(color) ~= "number" then
		return nil
	end

	local function clamp(value)
		return math.max(0, math.min(255, value))
	end

	local r = math.floor(color / 0x10000) % 0x100
	local g = math.floor(color / 0x100) % 0x100
	local b = color % 0x100

	r = clamp(r + delta)
	g = clamp(g + delta)
	b = clamp(b + delta)

	return r * 0x10000 + g * 0x100 + b
end

return M
