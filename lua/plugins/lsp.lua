-- Loading capabilities
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
}

local null_ls = require("null-ls")
local null_ls_sources = {
    null_ls.builtins.diagnostics.mypy.with({
        only_local =  ".venv/bin/",
    }),
    null_ls.builtins.diagnostics.pylint.with({
        only_local =  ".venv/bin",
    }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
}

null_ls.setup({
    sources = null_ls_sources
})

require("mason-null-ls").setup({
    ensure_installed = { nil },
    automatic_installation = false,
    automatic_setup = false,
})

-- Mappings applying even without lsp (vim diagnostics)
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>l', vim.diagnostic.setloclist, opts)

-- Mappings that will activate only after an lsp is attached)
-- They have to be passed as arguments on every lsp setup below
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>z', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'lsf', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require("lspconfig").pylsp.setup{
    on_attach = on_attach,
    capabilities = lsp_defaults.capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'E203', 'W503'},
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
                    ignore = {'E203', 'W503'},
                    maxLineLength = 88,
                },
            },
        },
    },
}

require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    capabilities = lsp_defaults.capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = {'vim'} },
        },
    },
})

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
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)
