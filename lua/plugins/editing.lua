return {
	{
		"terrortylor/nvim-comment",
		main = "nvim_comment",
		opts = { comment_empty = false },
	},

	-- lsp provider tends to slow down other lsp functionnalities, and it sometimes gives flashing, so we use treesitter if possible (tested only on pylsp)
	{
		"RRethy/vim-illuminate",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "CursorMoved", "InsertLeave" },
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"neotree",
					"neo-tree",
					"Telescope",
					"telescope",
				},
			})
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim", -- Rainbow delimiters
		main = "rainbow-delimiters.setup",
		opts = {
			highlight = {
				"RainbowDelimiterOrange",
				"RainbowDelimiterBlue",
				"RainbowDelimiterViolet",
				"RainbowDelimiterGreen",
				"RainbowDelimiterCyan",
			},
		},
	},
	"machakann/vim-sandwich",
	"LunarWatcher/auto-pairs",
}
