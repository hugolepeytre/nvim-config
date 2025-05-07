require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
local wk = require("which-key")
local aerial = require("aerial")

local colors = require("hugo.colors")

-- mode defaults to "n"
wk.add({
	mode = "n",
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

-- Aerial in operator pending mode
wk.add({
	mode = "o",
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
	mode = "x",
	{ "J", ":m '>+1<CR>gv=gv", desc = "Move line down" },
	{ "K", ":m '<-2<CR>gv=gv", desc = "Move line up" },
	{ "{", "<cmd>AerialPrev<CR>", desc = "Go to prev aerial symbol" },
	{ "}", "<cmd>AerialNext<CR>", desc = "Go to next aerial symbol" },
})

wk.add({
	mode = "x",
	{ "<leader>d", '"_d', desc = "Delete to void" },
	{ "<leader>p", '"_dP', desc = "Paste and keep register" },
	{ "<leader>y", '"+y', desc = "Yank to system keyboard" },
})

wk.add({
	mode = "n",
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
	{ "<leader>nk", builtin.git_commits, desc = "Search Git commits" },
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
	{ "s", "<nop>", desc = "For sandwich" },
	{ "<leader>y", '"+y', desc = "Yank to system clipboard" },
})

-- Trial to use gs instead of s for sandwich for chiller timeout
wk.add({
	mode = "xn",
	{ "gsa", "<Plug>(sandwich-add)", desc = "Alt sandwich add" },
	{ "gsd", "<Plug>(sandwich-delete)", desc = "Alt sandwich delete" },
	{ "gsr", "<Plug>(sandwich-replace)", desc = "Alt sandwich replace" },
})

-- Trial to use gs instead of s for sandwich for chiller timeout
wk.add({
	mode = "n",
	{ "gsdb", "<Plug>(sandwich-delete-auto)", desc = "Alt sandwich delete auto" },
	{ "gsrb", "<Plug>(sandwich-replace-auto)", desc = "Alt sandwich replace auto" },
})

-- Trial to use gs instead of s for sandwich for chiller timeout
wk.add({
	mode = "o",
	{ "gsa", "<Plug>(sandwich-add)", desc = "Alt sandwich add" },
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
