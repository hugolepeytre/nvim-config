local wk = require("which-key")
wk.register({
    n = {
        e = { "<CMD>Oil<CR>", "Local directory" }, -- Was vim.cmd.Ex before Oil

        p = { ":b#<CR>", "Previous buffer" },
    },
    J = { "mzJ`z", "Merge next line" },
    K = { "i<CR><ESC>", "Split line" },

    y = { '"+y', "Yank to system clipboard" },
    Y = { '"+Y', "Yank to system clipboard" },
    p = { '"+p', "Paste from system clipboard" },
    P = { '"+P', "Paste from system clipboard" },

    m = { "@@", "Repeat previous macro" },

    d = { '"_d', "Delete to void" },

    s = { "<nop>", "For sandwich" },
}, {
    prefix = "<leader>",
})

wk.register({
    -- Fast vertical movement keeping cursor centered
    J = { "<C-d>zz", "Move up, center cursor" },
    K = { "<C-u>zz", "Move down, center cursor" },
    n = { "nzzzv", "Next search match, center cursor" },
    N = { "Nzzzv", "Previous search match, center cursor" },
})

wk.register({
    -- Moving lines up and down in visual mode
    J = { ":m '>+1<CR>gv=gv", "Move line down" },
    K = { ":m '<-2<CR>gv=gv", "Move line up" },
}, {
    mode = "x",
})

wk.register({ -- visual, with leader
    -- yank to system keyboard
    y = { '"+y', "Yank to system keyboard" },
    -- Delete to void register. Paste without losing register
    d = { '"_d', "Delete to void" },
    p = { '"_dP', "Paste and keep register" },
}, {
    mode = "x",
    prefix = "<leader>",
})
