require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
local wk = require("which-key")
local aerial = require("aerial")

local colors = require("hugo.colors")

-- Modes
-- n - normal
-- x - visual
-- o - operator-pending
--
-- Mappings used
-- <leader>n - project [n]avigation
-- <leader>w - [w]indow (toggle displays)
-- <leader>h - sandwich ([h]ug)
-- s [+ single letter] for common actions
--
-- Letters left for more common actions
-- x
-- m
-- r (I actually use this sometimes)
-- z (scary)

-- Disabling default s in all modes
local function disable_builtin_maps()
	wk.add({
		mode = "xno",
		{ "s", "<nop>", desc = "disabled" },
		{ "<leader>s", "<nop>", desc = "disabled" },
		{ "x", "<nop>", desc = "disabled" },
		{ "m", "<nop>", desc = "disabled" },
	})
end
disable_builtin_maps()

-- QoL remaps (normal)
local function qol_remaps_normal()
	wk.add({
		mode = "n",
		{ "<C-w>v", ":95 vsplit<CR>", desc = "Vertical split with correct width" },
		{ "J", "<C-d>zz", desc = "Move up, center cursor" },
		{ "K", "<C-u>zz", desc = "Move down, center cursor" },
		{ "N", "Nzzzv", desc = "Previous search match, center cursor" },
		{ "n", "nzzzv", desc = "Next search match, center cursor" },
	})
end
qol_remaps_normal()

-- QoL remaps (visual)
local function qol_remaps_visual()
	wk.add({
		mode = "x",
		{ "J", ":m '>+1<CR>gv=gv", desc = "Move line down" },
		{ "K", ":m '<-2<CR>gv=gv", desc = "Move line up" },
	})
end
qol_remaps_visual()

-- QoL additional (leader) mappings (normal)
local function qol_maps_normal()
	wk.add({
		mode = "n",
		{ "<leader>J", "mzJ`z", desc = "Merge next line" },
		{ "<leader>K", "i<CR><ESC>", desc = "Split line" },
		{ "<leader>p", '"+p', desc = "Paste from system clipboard" },
		{ "<leader>P", '"+P', desc = "Paste from system clipboard" },
		{ "<leader>y", '"+y', desc = "Yank to system clipboard" },
		{ "<leader>Y", '"+Y', desc = "Yank to system clipboard" },
		{ "<leader>d", '"_d', desc = "Delete to void" },
		{ "<leader>m", "@@", desc = "Repeat previous macro" },
	})
end
qol_maps_normal()

-- QoL additional (leader) mappings (visual)
local function qol_maps_visual()
	wk.add({
		mode = "x",
		{ "<leader>d", '"_d', desc = "Delete to void" },
		{ "<leader>y", '"+y', desc = "Yank to system keyboard" },
		{ "<leader>p", '"_dP', desc = "Paste and keep register" },
	})
end
qol_maps_visual()

local function theming_maps()
	wk.add({
		mode = "n",
		{ "<leader>cf", colors.set_dark_theme, desc = "Set theme to dark" },
		{ "<leader>cj", colors.set_light_theme, desc = "Set theme to light" },
	})
end
theming_maps()

-- Navigation remaps (Aerial) (all modes)
-- normal/visual for navigation.
-- operator-pending to work as normal movement command in e.g. d or c commands.
local function aerial_maps()
	wk.add({
		mode = "xno",
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
end
aerial_maps()

local function sandwich_maps()
	wk.add({
		mode = "xn",
		{ "<leader>ha", "<Plug>(sandwich-add)", desc = "Alt sandwich add" },
		{ "<leader>hd", "<Plug>(sandwich-delete)", desc = "Alt sandwich delete" },
		{ "<leader>hr", "<Plug>(sandwich-replace)", desc = "Alt sandwich replace" },
		{ "<leader>hdb", "<Plug>(sandwich-delete-auto)", desc = "Alt sandwich delete auto" },
		{ "<leader>hrb", "<Plug>(sandwich-replace-auto)", desc = "Alt sandwich replace auto" },
	})
end
sandwich_maps()

local function frequent_action_maps()
	local lspbuf = vim.lsp.buf
	local neogen = require("neogen")

	wk.add({
		mode = "n",
		{ "sp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" } },
		{ "sn", vim.diagnostic.goto_next, { desc = "Next diagnostic" } },

		{ "sg", lspbuf.definition, { desc = "Go to definition" } },
		{ "st", lspbuf.type_definition, { desc = "Type definition" } },
		{ "sh", lspbuf.hover, { desc = "Hover" } },
		{ "si", lspbuf.references, { desc = "See references" } },

		{ "sv", lspbuf.rename, { desc = "Rename" } },
		{ "sc", neogen.generate, { desc = "Insert docstring" } },

		{
			"sj",
			function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end,
			desc = "Select outer function",
		},
		{
			"sk",
			function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end,
			desc = "Select inner function",
		},
		{
			"su",
			function()
				aerial.prev_up(1)
			end,
			desc = "Go to prev aerial symbol",
		},
		{
			"sl",
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter select",
		},
	})
end
frequent_action_maps()

-- Navigation
local function navigation_maps()
	local function live_grep_with_args()
		builtin.live_grep({
			vimgrep_arguments = {
				-- Default arguments
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- Additional arguments (from ripgrep docs, rg -h)
				"--hidden", -- Searches hidden files
			},
		})
	end

	local function file_search_with_args()
		builtin.find_files({
			hidden = true,
			no_ignore = true,
			file_ignore_patterns = { "node_modules", ".git$", ".venv" },
		})
	end

	wk.add({
		mode = "n",
		-- Filesystem navigation
		{ "<leader>nb", "<cmd>:Neotree current reveal toggle<CR>", desc = "Toogle filetree view" },
		{ "<leader>ne", "<CMD>Oil<CR>", desc = "Local directory" },

		-- Project-wide searches
		{ "<leader>nr", builtin.git_files, desc = "Search Git tracked filenmes" },
		{ "<leader>nw", file_search_with_args, desc = "Search filenames" },
		{ "<leader>nq", live_grep_with_args, desc = "Search words in files" },
		{ "<leader>nd", builtin.lsp_workspace_symbols, desc = "Search workspace symbols" },

		-- Inter-buffer navigation
		{ "<leader>np", ":b#<CR>", desc = "Previous buffer" },
		{ "<leader>nt", builtin.buffers, desc = "Search open buffers" },

		-- Window navigation
		{ "<leader>nf", builtin.current_buffer_fuzzy_find, desc = "Fuzzsearch buffer symbols" },
		{ "<leader>na", ":Telescope aerial<CR>", desc = "Search through aerial symbols" },
		{ "<leader>ng", builtin.treesitter, desc = "Search treesitter symbols" },
	})
end
navigation_maps()

local function quickfix_maps()
	wk.add({
		mode = "n",
		{ "<leader>qn", ":cn<CR>", desc = "Next entry in quickfix list" },
		{ "<leader>qp", ":cp<CR>", desc = "Previous entry in quickfix list" },
	})
end
quickfix_maps()

local function window_maps()
	wk.add({
		mode = "n",
		{ "<leader>wi", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
		{
			"<leader>wc",
			function()
				require("treesitter-context").toggle()
			end,
			desc = "Toggle Treesitter context",
		},
		-- TODO : add toggle quickfix from quicker.nvim
	})
end
window_maps()
