-- <leader> key
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
    -- Telescope for navigating files (can be used for lots of other stuff)
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    -- Treesitter (only for highlighting rn)
    {'nvim-treesitter/nvim-treesitter'},

    -- LSP
    {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" }, },
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    -- Scala Metals does not go through LSP ofc that would be too normal
    ({'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim" }}),

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },

    -- Additional features
    "machakann/vim-sandwich",-- add or delete around selections
    "terrortylor/nvim-comment",-- comment with gc{motion}
    "LunarWatcher/auto-pairs",-- Autoclose pairs like brackets and quotes

    -- Color theme
    ({
        "EdenEast/nightfox.nvim",
        as = "nightfox",
    }),
})
