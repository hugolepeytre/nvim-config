return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			-- a list of parser names, or "all" (the first four listed parsers should always be installed)
			ensure_installed = {
				"bash",
				"c",
				"lua",
				"vim",
				"vimdoc",
				"rust",
				"python",
				"scala",
				"r",
				"toml",
				"markdown",
				"typescript",
				"tsx",
			},

			indent = { enable = true },
			highlight = { enable = true },
			folds = { enable = true },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					-- ['@class.outer'] = '<c-v>', -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
	},
	-- First install broke line numbers for some reason ? Seems fine now tho
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "windwp/nvim-ts-autotag", opts = {} },
}
