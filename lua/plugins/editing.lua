return {
	"machakann/vim-sandwich", -- add or delete around selections
	{
		"terrortylor/nvim-comment",
		main = "nvim_comment",
		opts = { comment_empty = false },
	},

	"LunarWatcher/auto-pairs", -- Autoclose pairs like brackets and quotes
	-- lsp provider tends to slow down other lsp functionnalities, and it sometimes gives flashing, so we use treesitter if possible (tested only on pylsp)
	{
		"RRethy/vim-illuminate",
		lazy = true,
		enabled = true,
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
}
