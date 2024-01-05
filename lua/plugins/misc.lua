require("oil").setup()
require("nvim_comment").setup({ comment_empty = false })
-- lsp provider tends to slow down other lsp functionnalities, and it sometimes gives flashing, so we use treesitter if possible (tested only on pylsp)
require('illuminate').configure({
    modes_allowlist = { 'n' },
    providers = { 'treesitter', 'lsp', 'regex' },
    min_count_to_highlight = 2
})

require('rainbow-delimiters.setup').setup {
    highlight = {
        "RainbowDelimiterOrange",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterGreen",
        "RainbowDelimiterCyan",
    },
}

-- Quickfix for non-ugly rainbow parentheses.
-- Should pr to integrate in nightfox and remove the highlight groups I don't want
local blue = "#719cd6"
local cyan = "#63cdcf"
local green = "#236e37"
local orange = "#f4a261"
local violet = "#9d79d6"
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = blue })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = orange })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = green })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = violet })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = cyan })
