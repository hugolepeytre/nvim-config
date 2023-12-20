-- Loading capabilities
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local map = vim.keymap.set
local api = vim.api
local lspbuf = vim.lsp.buf

lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
})

-- Mappings for vim diagnostics
map("n", "s<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Open Float (?)" })
map("n", "s<leader>wd", vim.diagnostic.setqflist, { noremap = true, silent = true, desc = "Add to quickfix list" })
map("n", "sp", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
map("n", "sn", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
map("n", "sl", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Add to loclist" })

-- Mappings for lsp
map("n", "sD", lspbuf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
map("n", "sgd", lspbuf.definition, { noremap = true, silent = true, desc = "Go to definition" })
map("n", "sh", lspbuf.hover, { noremap = true, silent = true, desc = "Hover" })
map("n", "si", lspbuf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
map("n", "s<leader>h", lspbuf.signature_help, { noremap = true, silent = true, desc = "Signature help" })
map("n", "s<leader>ws", lspbuf.workspace_symbol, { noremap = true, silent = true, desc = "Workspace symbol (?)" })
map("n", "s+", lspbuf.add_workspace_folder, { noremap = true, silent = true, desc = "Add workspace folder (?)" })
map("n", "s-", lspbuf.remove_workspace_folder, { noremap = true, silent = true, desc = "Remove workspace folder (?)" })
map("n", "sf", lspbuf.format, { noremap = true, silent = true, desc = "Format" })
map("n", "s_", function()
    print(vim.inspect(lspbuf.list_workspace_folders()))
end, { noremap = true, silent = true, desc = "List workspace folders" })
map("n", "st", lspbuf.type_definition, { noremap = true, silent = true, desc = "Type definition" })
map("n", "sv", lspbuf.rename, { noremap = true, silent = true, desc = "Rename" })
map("n", "s<leader>a", lspbuf.code_action, { noremap = true, silent = true, desc = "Code actions" })
map("n", "s<leader>r", lspbuf.references, { noremap = true, silent = true, desc = "See references" })

lspconfig.pylsp.setup({
    capabilities = lsp_defaults.capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                },
            },
        },
    },
})

lspconfig.lua_ls.setup({
    capabilities = lsp_defaults.capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

lspconfig.tsserver.setup({
    capabilities = lsp_defaults.capabilities,
})

lspconfig.rust_analyzer.setup({
    capabilities = lsp_defaults.capabilities,
    on_attach = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
    settings = {
        -- Other settings here
        -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
            diagnostics = {
                enable = false,
            },
            check = {
                command = "clippy",
            },
        },
    },
})

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
