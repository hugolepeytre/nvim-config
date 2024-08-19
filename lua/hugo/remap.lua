require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
local wk = require("which-key")
local aerial = require("aerial")

local colors = require("hugo.colors")

wk.add({
	{ "<C-w>v", ":95 vsplit<CR>", desc = "Vertical split with correct width" },
	{ "J", "<C-d>zz", desc = "Move up, center cursor" },
	{ "K", "<C-u>zz", desc = "Move down, center cursor" },
	{ "N", "Nzzzv", desc = "Previous search match, center cursor" },
	{ "n", "nzzzv", desc = "Next search match, center cursor" },
	{
		"{",
		function()
			aerial.prev(math.max(1, vim.v.count))
		end,
		desc = "Go to prev aerial symbol",
	},
	{
		"}",
		function()
			aerial.next(math.max(1, vim.v.count))
		end,
		desc = "Go to next aerial symbol",
	},
})

wk.add({
	mode = { "o" },
	{
		"{",
		function()
			aerial.prev(math.max(1, vim.v.count))
		end,
		desc = "Go to prev aerial symbol",
	},
	{
		"}",
		function()
			aerial.next(math.max(1, vim.v.count))
		end,
		desc = "Go to next aerial symbol",
	},
})

-- wk.register({
-- 	-- Moving lines up and down in visual mode
-- 	J = { ":m '>+1<CR>gv=gv", "Move line down" },
-- 	K = { ":m '<-2<CR>gv=gv", "Move line up" },
-- 	["{"] = { "<cmd>AerialPrev<CR>", "Go to prev aerial symbol" },
-- 	["}"] = { "<cmd>AerialNext<CR>", "Go to next aerial symbol" },
-- }, {
-- 	mode = "x",
-- })

wk.add({
	{
		mode = { "x" },
		{ "J", ":m '>+1<CR>gv=gv", desc = "Move line down" },
		{ "K", ":m '<-2<CR>gv=gv", desc = "Move line up" },
		{ "{", "<cmd>AerialPrev<CR>", desc = "Go to prev aerial symbol" },
		{ "}", "<cmd>AerialNext<CR>", desc = "Go to next aerial symbol" },
	},
})
-- wk.register({ -- visual, with leader
-- 	-- yank to system keyboard
-- 	y = { '"+y', "Yank to system keyboard" },
-- 	-- Delete to void register. Paste without losing register
-- 	d = { '"_d', "Delete to void" },
-- 	p = { '"_dP', "Paste and keep register" },
-- }, {
-- 	mode = "x",
-- 	prefix = "<leader>",
-- })

wk.add({
	{
		mode = { "x" },
		{ "<leader>d", '"_d', desc = "Delete to void" },
		{ "<leader>p", '"_dP', desc = "Paste and keep register" },
		{ "<leader>y", '"+y', desc = "Yank to system keyboard" },
	},
})

-- wk.register({
-- 	n = {
-- 		q = { builtin.live_grep, "Search words in files" },
-- 		w = {
-- 			function()
-- 				builtin.find_files({ no_ignore = true })
-- 			end,
-- 			"Search filenames",
-- 		},
-- 		e = { "<CMD>Oil<CR>", "Local directory" }, -- Was vim.cmd.Ex before Oil
-- 		r = { builtin.git_files, "Search Git tracked filenmes" },
-- 		t = { builtin.buffers, "Search open buffers" },

-- 		a = { ":Telescope aerial<CR>", "Search through aerial symbols" },
-- 		s = { builtin.lsp_document_symbols, "Search document symbols" },
-- 		d = { builtin.lsp_workspace_symbols, "Search workspace symbols" },
-- 		f = { builtin.current_buffer_fuzzy_find, "Fuzzsearch buffer symbols" },
-- 		g = { builtin.treesitter, "Search treesitter symbols" },

-- 		z = {
-- 			function()
-- 				builtin.diagnostics({ bufnr = 0 })
-- 			end,
-- 			"Search buffer diagnostics",
-- 		},
-- 		x = { builtin.diagnostics, "Search project diagnostics" },
-- 		c = { builtin.loclist, "Search loclist" },
-- 		v = { builtin.keymaps, "Search normal mode mappings" },
-- 		b = { "<cmd>:Neotree current reveal toggle<CR>", "Toogle filetree view" },

-- 		i = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
-- 		o = { require("telescope").extensions.metals.commands, "Scala Metals commands" },
-- 		p = { ":b#<CR>", "Previous buffer" },
-- 	},
-- 	J = { "mzJ`z", "Merge next line" },
-- 	K = { "i<CR><ESC>", "Split line" },

-- 	y = { '"+y', "Yank to system clipboard" },
-- 	Y = { '"+Y', "Yank to system clipboard" },
-- 	p = { '"+p', "Paste from system clipboard" },
-- 	P = { '"+P', "Paste from system clipboard" },

-- 	m = { "@@", "Repeat previous macro" },

-- 	d = { '"_d', "Delete to void" },

-- 	s = { "<nop>", "For sandwich" },

-- 	c = {
-- 		f = { colors.set_dark_theme, "Set theme to dark" },
-- 		j = { colors.set_light_theme, "Set theme to light" },
-- 	},
-- }, {
-- 	prefix = "<leader>",
-- })

wk.add({
	{ "<leader>J", "mzJ`z", desc = "Merge next line" },
	{ "<leader>K", "i<CR><ESC>", desc = "Split line" },
	{ "<leader>P", '"+P', desc = "Paste from system clipboard" },
	{ "<leader>Y", '"+Y', desc = "Yank to system clipboard" },
	{ "<leader>cf", colors.set_dark_theme, desc = "Set theme to dark" },
	{ "<leader>cj", colors.set_light_theme, desc = "Set theme to light" },
	{ "<leader>d", '"_d', desc = "Delete to void" },
	{ "<leader>m", "@@", desc = "Repeat previous macro" },
	{ "<leader>na", ":Telescope aerial<CR>", desc = "Search through aerial symbols" },
	{ "<leader>nb", "<cmd>:Neotree current reveal toggle<CR>", desc = "Toogle filetree view" },
	{ "<leader>nc", builtin.loclist, desc = "Search loclist" },
	{ "<leader>nd", builtin.lsp_workspace_symbols, desc = "Search workspace symbols" },
	{ "<leader>ne", "<CMD>Oil<CR>", desc = "Local directory" },
	{ "<leader>nf", builtin.current_buffer_fuzzy_find, desc = "Fuzzsearch buffer symbols" },
	{ "<leader>ng", builtin.treesitter, desc = "Search treesitter symbols" },
	{ "<leader>ni", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
	{ "<leader>no", require("telescope").extensions.metals.commands, desc = "Scala Metals commands" },
	{ "<leader>np", ":b#<CR>", desc = "Previous buffer" },
	{ "<leader>nq", builtin.live_grep, desc = "Search words in files" },
	{ "<leader>nr", builtin.git_files, desc = "Search Git tracked filenmes" },
	{ "<leader>ns", builtin.lsp_document_symbols, desc = "Search document symbols" },
	{ "<leader>nt", builtin.buffers, desc = "Search open buffers" },
	{ "<leader>nv", builtin.keymaps, desc = "Search normal mode mappings" },
	{
		"<leader>nw",
		function()
			builtin.find_files({ no_ignore = true })
		end,
		desc = "Search filenames",
	},
	{ "<leader>nx", builtin.diagnostics, desc = "Search project diagnostics" },
	{
		"<leader>nz",
		function()
			builtin.diagnostics({ bufnr = 0 })
		end,
		desc = "Search buffer diagnostics",
	},
	{ "<leader>p", '"+p', desc = "Paste from system clipboard" },
	{ "<leader>s", "<nop>", desc = "For sandwich" },
	{ "<leader>y", '"+y', desc = "Yank to system clipboard" },
})

local map = vim.keymap.set
local lspbuf = vim.lsp.buf
map("n", "s<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Open Float (?)" })
map("n", "s<leader>wd", vim.diagnostic.setqflist, { noremap = true, silent = true, desc = "Add to quickfix list" })
map("n", "sp", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
map("n", "sn", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
map("n", "sl", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Add to loclist" })

-- Mappings for lsp
map("n", "sD", lspbuf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
map("n", "sgd", lspbuf.definition, { noremap = true, silent = true, desc = "Go to definition" })
map("n", "sh", lspbuf.hover, { noremap = true, silent = true, desc = "Hover" })
map("n", "si", lspbuf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
map("n", "s<leader>h", lspbuf.signature_help, { noremap = true, silent = true, desc = "Signature help" })
map("n", "s<leader>ws", lspbuf.workspace_symbol, { noremap = true, silent = true, desc = "Workspace symbol (?)" })
map("n", "s+", lspbuf.add_workspace_folder, { noremap = true, silent = true, desc = "Add workspace folder (?)" })
map("n", "s-", lspbuf.remove_workspace_folder, { noremap = true, silent = true, desc = "Remove workspace folder (?)" })
map("n", "sf", lspbuf.format, { noremap = true, silent = true, desc = "Format" })
map("n", "s_", function()
	print(vim.inspect(lspbuf.list_workspace_folders()))
end, { noremap = true, silent = true, desc = "List workspace folders" })
map("n", "st", lspbuf.type_definition, { noremap = true, silent = true, desc = "Type definition" })
map("n", "sv", lspbuf.rename, { noremap = true, silent = true, desc = "Rename" })
map("n", "s<leader>a", lspbuf.code_action, { noremap = true, silent = true, desc = "Code actions" })
map("n", "s<leader>r", lspbuf.references, { noremap = true, silent = true, desc = "See references" })
local neogen = require("neogen")
map("n", "sc", neogen.generate, { desc = "Insert docstring" })
