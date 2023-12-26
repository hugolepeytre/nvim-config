-- TODOS
-- Command to automatically start the right kernel
-- Image display support (long + not everything is in the readme)
-- Working inside ipynb files
-- Converting to and from ipynb files
-- Saving session's outputs
local map = vim.keymap.set
map("n", "ssi", ":MoltenInit<CR>", { desc = "Initialize Molten kernel" })
map("n", "ssr", ":MoltenRestart!<CR>", { desc = "Restart current kernel and delete outputs" })
map("n", "ssgg", ":MoltenGoto<CR>", { desc = "Go to first cell" })
map("n", "ssgo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Enter cell's output" })
map("n", "ssj", ":MoltenNext<CR>", { desc = "Go to next cell" })
map("n", "ssk", ":MoltenPrev<CR>", { desc = "Go to previous cell" })
map("n", "ssd", ":MoltenDelete<CR>", { desc = "Delete current cell" })
map("n", "ssel", ":MoltenEvaluateLine<CR>", { desc = "Evaluate current line" })
map("n", "sser", ":MoltenReevaluateCell<CR>", { desc = "Reevaluate current cell" })
map("v", "sse", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate current line" })

-- After installing molten, run :UpdateRemotePlugins

-- A project's venv needs to have ipykernel installed, then running :
-- python -m ipykernel install --user --name project_name
-- While the venv is active

-- Then kernel has to be init before anything works
