local plugin_config = require("plugins.helpers").config

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		config = plugin_config("telescope"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
