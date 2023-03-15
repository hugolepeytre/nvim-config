vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope for navigating files (can be used for lots of other stuff)
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter (only for highlighting rn)
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" }, },
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
    }
    -- Scala Metals does not go through LSP ofc that would be too normal
    use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    }

    -- Additional features
    use "machakann/vim-sandwich" -- add or delete around selections
    use "terrortylor/nvim-comment" -- comment with gc{motion}
    use "jiangmiao/auto-pairs" -- Autoclose pairs like brackets and quotes

    -- Color theme
    use({
        "EdenEast/nightfox.nvim",
        as = "nightfox",
    })
end)
