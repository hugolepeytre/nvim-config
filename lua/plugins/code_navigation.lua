return {
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			layout = {
				max_width = { 21, 0.15 },
				placement = "edge",
			},

			attach_mode = "global",

			highlight_mode = "last",

			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Method",
				"Struct",
			},

			-- Highlight the closest symbol if the cursor is not exactly on one.
			highlight_closest = true,

			-- The autocmds that trigger symbols update (not used for LSP backend)
			update_events = "InsertLeave,BufWritePost",

			nerd_fond = "true",

			icons = {
				Class = "C",
				Constructor = "@",
				Enum = "E",
				Function = "@",
				Interface = "I",
				Module = "M",
				Method = "@",
				Struct = "S",
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					enabled = false,
				},
			},
		},
	},
}
