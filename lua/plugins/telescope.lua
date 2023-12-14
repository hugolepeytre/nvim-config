require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>na", builtin.find_files, {})
vim.keymap.set("n", "<leader>nw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>nf", builtin.git_files, {})
vim.keymap.set("n", "<leader>no", builtin.buffers, {})
vim.keymap.set("n", "<leader>ns", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>nm", require("telescope").extensions.metals.commands, {})
