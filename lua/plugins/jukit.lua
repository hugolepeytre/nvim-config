vim.g.jukit_mappings = 0
vim.g.jukit_mappings_ext_enabled = { "py", "ipynb" }

local map = vim.keymap.set
map("n", "sso", ":call jukit#splits#output()<cr>", { desc = "Open split and run shell cmd" })
map("n", "ssh", ":call jukit#splits#history()<cr>", { desc = "Open output history" })
map("n", "ssH", ":call jukit#splits#close_history()<cr>", { desc = "Close output history" })
map("n", "ssO", ":call jukit#splits#close_output_split()<cr>", { desc = "Close output split" })
map("n", "ssD", ":call jukit#splits#out_hist_scroll(1)<cr>", { desc = "Scroll down in history" })
map("n", "ssU", ":call jukit#splits#out_hist_scroll(0)<cr>", { desc = "Scroll up in history" })
map("n", "ssr", ":call jukit#splits#show_last_cell_output(1)<cr>", { desc = "Diplay last output for current cell" })

map("n", "sse", ":call jukit#send#section(0)<cr>", { desc = "Evaluate current cell in output" })
map("n", "ssl", ":call jukit#send#line<cr>", { desc = "Evaluate current line in output" })
map("n", "ssa", ":call jukit#send#all<cr>", { desc = "Execute all cells" })

map("n", "ssco", ":call jukit#cells#create_below(0)<cr>", { desc = "Create cell below" })
map("n", "sscO", ":call jukit#cells#create_above(0)<cr>", { desc = "Create cell above" })
map("n", "ssto", ":call jukit#cells#create_below(1)<cr>", { desc = "Create text below" })
map("n", "sstO", ":call jukit#cells#create_above(1)<cr>", { desc = "Create text above" })
map("n", "ssd", ":call jukit#cells#delete()<cr>", { desc = "Delete current cell" })
map("n", "ssk", ":call jukit#cells#move_up()<cr>", { desc = "Move cell up" })
map("n", "ssj", ":call jukit#cells#move_down()<cr>", { desc = "Move cell down" })
map("n", "ssJ", ":call jukit#cells#jump_to_next_cell()<cr>", { desc = "Go to next cell" })
map("n", "ssK", ":call jukit#cells#jump_to_previous_cell()<cr>", { desc = "Go to previous cell" })
map("n", "ssw", ":call jukit#cells#delete_outputs(1)<cr>", { desc = "Delete saved outputs" })

map(
	"n",
	"ssg",
	':call jukit#convert#notebook_convert("jupyter-notebook")<cr>',
	{ desc = "Convert between py and ipynb" }
)
