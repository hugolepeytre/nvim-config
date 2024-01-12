-- <leader> key (has to be registered before lazy in the config)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { "EdenEast/nightfox.nvim",                   priority = 1000 },

    -- Filesystem navigation
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },


    -- Code navigation
    {
        'stevearc/aerial.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "S",         mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",         mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",         mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },


    -- Treesitter (highlighting + illuminate)
    { "nvim-treesitter/nvim-treesitter" },

    -- LSP
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
        },
    },
    { "scalameta/nvim-metals",          dependencies = { "nvim-lua/plenary.nvim" } },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        opts = {},
    },

    -- Linting
    "mfussenegger/nvim-lint",

    -- Key binding finder
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },


    -- Statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        function()
                            local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
                            local icon =
                                require("nvim-web-devicons").get_icon_by_filetype(vim.api.nvim_buf_get_option(0,
                                    "filetype"))
                            if lsps and #lsps > 0 then
                                local names = {}
                                for _, lsp in ipairs(lsps) do
                                    table.insert(names, lsp.name)
                                end
                                return string.format("%s %s", table.concat(names, ", "), icon)
                            else
                                return icon or ""
                            end
                        end,
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                    },
                },
                lualine_c = { "filename" },

                lualine_x = { "diff", "branch" },
                lualine_y = { "aerial", "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { "filename" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        },
    },

    -- Additional features
    "machakann/vim-sandwich", -- add or delete around selections
    {
        "terrortylor/nvim-comment",
        main = "nvim_comment",
        opts = { comment_empty = false },
    },

    "LunarWatcher/auto-pairs", -- Autoclose pairs like brackets and quotes
    -- lsp provider tends to slow down other lsp functionnalities, and it sometimes gives flashing, so we use treesitter if possible (tested only on pylsp)
    {
        'RRethy/vim-illuminate',
        lazy = true,
        enabled = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        event = { 'CursorMoved', 'InsertLeave' },
        config = function()
            require 'illuminate'.configure {
                filetypes_denylist = {
                    'neotree',
                    'neo-tree',
                    'Telescope',
                    'telescope',
                }
            }
        end
    },
    {
        "hiphish/rainbow-delimiters.nvim", -- Rainbow delimiters
        main = "rainbow-delimiters.setup",
        opts = {
            highlight = {
                "RainbowDelimiterOrange",
                "RainbowDelimiterBlue",
                "RainbowDelimiterViolet",
                "RainbowDelimiterGreen",
                "RainbowDelimiterCyan",
            },
        }
    },

    -- Jupyter management experiments
    "benlubas/molten-nvim",
    "goerz/jupytext.vim",
    "jmbuhr/otter.nvim",
    "quarto-dev/quarto-nvim",
})
