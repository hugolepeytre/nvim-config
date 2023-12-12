-- Loading capabilities
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local map = vim.keymap.set
local api = vim.api
local lspbuf = vim.lsp.buf

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
}

-- only_local ensures mypy and pylint see imports
local null_ls = require("null-ls")
local null_ls_sources = {
    -- null_ls.builtins.diagnostics.eslint_d.with({
    --     diagnostics_format = '[eslint] #{m}\n(#{c})',
    --     method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    -- }),
    null_ls.builtins.formatting.prettierd.with({}),
    null_ls.builtins.diagnostics.mypy.with({
        only_local = ".venv/bin/",
    }),
    null_ls.builtins.diagnostics.pylint.with({
        only_local = ".venv/bin",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
}

-- Ensures null_ls is always used for formatting
local lsp_formatting = function(bufnr)
    lspbuf.format({
        filter = function(client)
            -- Logic can be more complicated if needed
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- Format on save
local augroup = api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = null_ls_sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end,
})

require("mason-null-ls").setup({
    ensure_installed = { nil },
    automatic_installation = false,
    automatic_setup = false,
})

-- Mappings for vim diagnostics
local opts = { noremap = true, silent = true }
map('n', 's<leader>d', vim.diagnostic.open_float, opts)
map('n', 's<leader>wd', vim.diagnostic.setqflist)
map('n', 'sp', vim.diagnostic.goto_prev, opts)
map('n', 'sn', vim.diagnostic.goto_next, opts)
map('n', 'sl', vim.diagnostic.setloclist, opts)

-- Mappings for lsp
map('n', 'sD', lspbuf.declaration, opts)
map('n', 'sgd', lspbuf.definition, opts)
map('n', 'sh', lspbuf.hover, opts)
map('n', 'si', lspbuf.implementation, opts)
map('n', 's<leader>h', lspbuf.signature_help, opts)
map('n', 's<leader>ws', lspbuf.workspace_symbol, opts)
map('n', 's+', lspbuf.add_workspace_folder, opts)
map('n', 's-', lspbuf.remove_workspace_folder, opts)
map('n', 'sf', lspbuf.format, opts)
map('n', 's_', function()
    print(vim.inspect(lspbuf.list_workspace_folders()))
end, opts)
map('n', 'st', lspbuf.type_definition, opts)
map('n', 'sv', lspbuf.rename, opts)
map('n', 's<leader>a', lspbuf.code_action, opts)
map('n', 's<leader>r', lspbuf.references, opts)

lspconfig.pylsp.setup {
    capabilities = lsp_defaults.capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'E203', 'W503' },
                    maxLineLength = 88,
                },
                pydocstyle = {
                    enabled = true,
                },
                pylint = {
                    enabled = false,
                },
                flake8 = {
                    enabled = true,
                    ignore = { 'E203', 'W503' },
                    maxLineLength = 88,
                },
            },
        },
    },
}

lspconfig.lua_ls.setup({
    capabilities = lsp_defaults.capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
        },
    },
})

lspconfig.tsserver.setup({
    capabilities = lsp_defaults.capabilities,
})

lspconfig.rust_analyzer.setup {
    capabilities = lsp_defaults.capabilities,
    on_attach = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format { async = false }
            end
        })
    end,
    settings = {
        -- Other settings here
        -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ['rust-analyzer'] = {
            diagnostics = {
                enable = false,
            },
            check = {
                command = "clippy",
            },
        }
    }
}

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- Metals settings
local metals = require("metals")
local metals_config = metals.bare_config()

metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = {},
}

-- Starts Metals server
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        metals.initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
