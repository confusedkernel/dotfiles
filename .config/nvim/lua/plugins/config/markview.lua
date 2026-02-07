require("markview").setup({
	markdown_inline = {
		checkboxes = {
			["!"] = { text = "", hl = "MarkviewCheckboxUnchecked" },
			["~"] = { text = "󰰱", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },
			[">"] = { text = "", hl = "MarkviewCheckboxPending" },
		},
	},
})
