require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")

local wk = require("which-key")
wk.register({
	n = {
		q = { builtin.live_grep, "Search words in files" },
		w = {
			function()
				builtin.find_files({ no_ignore = true })
			end,
			"Search filenames",
		},
		r = { builtin.git_files, "Search Git tracked filenmes" },
		t = { builtin.buffers, "Search open buffers" },

		a = { ":Telescope aerial<CR>", "Search through aerial symbols" },
		s = { builtin.lsp_document_symbols, "Search document symbols" },
		d = { builtin.lsp_workspace_symbols, "Search workspace symbols" },
		f = { builtin.current_buffer_fuzzy_find, "Fuzzsearch buffer symbols" },
		g = { builtin.treesitter, "Search treesitter symbols" },

		z = { builtin.diagnostics, "Search diagnostics" },
		x = { builtin.quickfix, "Search quickfix" },
		c = { builtin.loclist, "Search loclist" },
		v = { builtin.keymaps, "Search normal mode mappings" },

		i = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
		o = { require("telescope").extensions.metals.commands, "Scala Metals commands" },
	},
}, {
	prefix = "<leader>",
})

vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { desc = "Go to next aerial symbol" })
vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { desc = "Go to prev aerial symbol" })

require("aerial").setup({
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
	update_events = "BufWritePost",

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
})
