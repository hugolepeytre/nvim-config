return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			-- a list of parser names, or "all" (the first four listed parsers should always be installed)
			ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python", "scala", "r", "toml", "markdown" },

			-- install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- automatically install missing parsers when entering buffer
			-- recommendation: set to false if you don't have `tree-sitter` cli installed locally
			auto_install = false,

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>v", -- set to `false` to disable one of the mappings
					node_incremental = ";",
					-- scope_incremental = ";",
					node_decremental = ",",
				},
			},

			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		},
	},
}
