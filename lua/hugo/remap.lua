-- Back to file list
vim.keymap.set("n", "<leader>ne", vim.cmd.Ex)

-- Moving lines up and down in visual mode
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

-- Split and merge lines, merge does not move cursor
vim.keymap.set("n", "<leader>J", "mzJ`z")
vim.keymap.set("n", "<leader>K", "i<CR><ESC>")

-- Fast vertical movement keeping cursor centered
vim.keymap.set("n", "J", "<C-d>zz")
vim.keymap.set("n", "K", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("x", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete to void register. Paste without losing register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("x", "<leader>d", "\"_d")
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Easier macro repeat
vim.keymap.set("n", "<leader>m", "@@")

-- For sandwich
vim.keymap.set("n", "s", "<nop>")

-- Buffer switching (navigation)
vim.keymap.set("n", "<leader>nb", ":b ")
vim.keymap.set("n", "<leader>np", ":b#<CR>")
