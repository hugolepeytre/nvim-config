require('lualine').setup {
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            },
        },
        lualine_c = { 'branch', 'diff' },
        lualine_d = { 'filetype', 'filename' },
        lualine_w = { 'aerial' },
        lualine_x = { 'buffers' },
        lualine_y = { 'progress', 'oil' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
    },
    winbar = {
    },
    inactive_winbar = {},
    extensions = {}
}
