-- TODOS
-- Image display support (long + not everything is in the readme)
-- Finish config quarto-nvim, otter
--
-- Features for now :
-- Can open ipynb with highlighting and execute code as cells then save modified code back to ipynb
-- Can run code cells in any python file. No need for ipynb except for collaboration
--
-- Problems for now :
-- Can't display images
-- Linting, formatting and most lsp functions unavailable inside ipynb (quarto-nvim and otter configs not finished)

-- Molten setup
local map = vim.keymap.set
map("n", "ssnr", ":MoltenRestart!<CR>", { desc = "Restart current kernel and delete outputs" })
map("n", "ssgg", ":MoltenGoto<CR>", { desc = "Go to first cell" })
map("n", "ssgo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Enter cell's output" })
map("n", "ssj", ":MoltenNext<CR>", { desc = "Go to next cell" })
map("n", "ssk", ":MoltenPrev<CR>", { desc = "Go to previous cell" })
map("n", "ssd", ":MoltenDelete<CR>", { desc = "Delete current cell" })
map("n", "ssel", ":MoltenEvaluateLine<CR>", { desc = "Evaluate current line" })
map("n", "ssr", ":MoltenReevaluateCell<CR>", { desc = "Reevaluate current cell" })
map("n", "ssos", ":MoltenShowOutput<CR>", { desc = "Show output" })
map("n", "ssoh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
map("v", "sse", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate current line" })

-- Initialize a kernel with the same name as the venv
map("n", "ssi", function()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv ~= nil then
        venv = string.match(venv, "/.+/(.+)") -- getting only the last part of the path
        vim.cmd(("MoltenInit %s"):format(venv))
    else
        vim.cmd("MoltenInit python3")
    end
end, { desc = "Initialize Molten kernel" })

vim.g.molten_output_virt_lines = true
-- After installing molten, run :UpdateRemotePlugins

-- A project's venv needs to have ipykernel installed, then running :
-- python -m ipykernel install --user --name project_name
-- While the venv is active

-- Then kernel has to be init before anything works


-- Quarto and otter setup (todo)
require('quarto').setup({
    lspFeatures = {
        languages = { 'python' },
        diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" }
        },
        completion = {
            enabled = true,
        },
    },
    codeRunner = {
        enabled = true,
        default_method = 'molten', -- 'molten' or 'slime'
    },
    keymap = {
        hover = 'K',
        definition = 'gd',
        rename = '<leader>lR',
        references = 'gr',
    }
})

local otter = require("otter")
map("n", "ssa", otter.dev_setup, { desc = "Activate otter" })
map("n", "ssgd", otter.ask_definition, { noremap = true, silent = true, desc = "Go to definition" })
map("n", "sst", otter.ask_type_definition, { noremap = true, silent = true, desc = "Type definition" })
map("n", "ssh", otter.ask_hover, { noremap = true, silent = true, desc = "Hover" })
map("n", "ss<leader>r", otter.ask_references, { noremap = true, silent = true, desc = "See references" })
map("n", "ssv", otter.ask_rename, { noremap = true, silent = true, desc = "Rename" })
map("n", "ssf", otter.ask_format, { noremap = true, silent = true, desc = "Format" })
