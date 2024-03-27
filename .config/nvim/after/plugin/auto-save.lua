require("auto-save").setup {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    execution_message = { enabled = false, },
    condition = function(buf)
        local fn = vim.fn

        -- don't save for special-buffers
        if fn.getbufvar(buf, "&buftype") ~= 'TelescopePrompt' then
            return false
        end
        return true
    end
}
