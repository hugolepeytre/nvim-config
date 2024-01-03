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

    -- Telescope for navigating files (can be used for lots of other stuff)
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    -- Treesitter (only for highlighting rn)
    { "nvim-treesitter/nvim-treesitter" },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
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

    -- Filesystem navigation
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Key binding finder
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },

    -- Highligh words under cursor
    "RRethy/vim-illuminate",

    -- Additional features
    "machakann/vim-sandwich",   -- add or delete around selections
    "terrortylor/nvim-comment", -- comment with gc{motion}
    "LunarWatcher/auto-pairs",  -- Autoclose pairs like brackets and quotes

    -- Jupyter management experiments
    "benlubas/molten-nvim",
    "goerz/jupytext.vim",
    "jmbuhr/otter.nvim",
    "quarto-dev/quarto-nvim",
})

require("oil").setup()
require("nvim_comment").setup({ comment_empty = false })
require('illuminate').configure({ min_count_to_highlight = 2 })
