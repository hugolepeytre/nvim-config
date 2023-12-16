require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")

local wk = require("which-key")
wk.register({
	n = {
		a = { builtin.find_files, "Search filenames" },
		w = { builtin.live_grep, "Search words in files" },
		f = { builtin.git_files, "Search Git tracked filenmes" },
		o = { builtin.buffers, "Search open buffers" },
		s = { builtin.lsp_dynamic_workspace_symbols, "Search workspace symbols" },
		m = { require("telescope").extensions.metals.commands, "Scala Metals commands" },
	},
}, {
	prefix = "<leader>",
})
