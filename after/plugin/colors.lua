require('nightfox').setup({
    options = {
        transparent = true
    }
})

vim.cmd.colorscheme('nightfox')

-- TODO choose correct colors
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#719cd6" })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#63cdcf" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#81b29a" })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f4a261" })
vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f4a261" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#9d79d6" })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#63cdcf" })
