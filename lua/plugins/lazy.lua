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
    { "EdenEast/nightfox.nvim", priority = 1000 },

    -- Filesystem navigation
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
            local builtin = require("telescope.builtin")

            local wk = require("which-key")
            wk.register({
                n = {
                    q = { builtin.live_grep, "Search words in files" },
                    w = {
                        function()
                            builtin.find_files({ no_ignore = true })
                        end,
                        "Search filenames",
                    },
                    r = { builtin.git_files, "Search Git tracked filenmes" },
                    t = { builtin.buffers, "Search open buffers" },

                    a = { ":Telescope aerial<CR>", "Search through aerial symbols" },
                    s = { builtin.lsp_document_symbols, "Search document symbols" },
                    d = { builtin.lsp_workspace_symbols, "Search workspace symbols" },
                    f = { builtin.current_buffer_fuzzy_find, "Fuzzsearch buffer symbols" },
                    g = { builtin.treesitter, "Search treesitter symbols" },

                    z = { builtin.diagnostics, "Search diagnostics" },
                    x = { builtin.quickfix, "Search quickfix" },
                    c = { builtin.loclist, "Search loclist" },
                    v = { builtin.keymaps, "Search normal mode mappings" },

                    i = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
                    o = { require("telescope").extensions.metals.commands, "Scala Metals commands" },
                },
            }, {
                prefix = "<leader>",
            })

            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { desc = "Go to next aerial symbol" })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { desc = "Go to prev aerial symbol" })
            vim.keymap.set("v", "{", "<cmd>AerialPrev<CR>", { desc = "Go to next aerial symbol" })
            vim.keymap.set("v", "}", "<cmd>AerialNext<CR>", { desc = "Go to prev aerial symbol" })

            require("aerial").setup({
                filter_kind = {
                    "Class",
                    "Constructor",
                    "Enum",
                    "Function",
                    "Interface",
                    "Module",
                    "Method",
                    "Struct",
                },

                -- Highlight the closest symbol if the cursor is not exactly on one.
                highlight_closest = true,

                -- The autocmds that trigger symbols update (not used for LSP backend)
                update_events = "BufWritePost",

                nerd_fond = "true",

                icons = {
                    Class = "C",
                    Constructor = "@",
                    Enum = "E",
                    Function = "@",
                    Interface = "I",
                    Module = "M",
                    Method = "@",
                    Struct = "S",
                },
            })

            vim.keymap.set("n", "<leader>nb", "<cmd>:Neotree current reveal toggle<CR>",
                { desc = "Toogle filetree view" })

            vim.fn.sign_define("DiagnosticSignError",
                { text = " ", texthl = "DiagnosticSignError" })
            vim.fn.sign_define("DiagnosticSignWarn",
                { text = " ", texthl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DiagnosticSignInfo",
                { text = " ", texthl = "DiagnosticSignInfo" })
            vim.fn.sign_define("DiagnosticSignHint",
                { text = "", texthl = "DiagnosticSignHint" })
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        opts = {
            sort_case_insensitive = true,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                },
                hijack_netrw_behavior = "disabled",
            },
        },
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
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            -- a list of parser names, or "all" (the first four listed parsers should always be installed)
            ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python", "scala", "r", "toml", "markdown" },

            -- install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- automatically install missing parsers when entering buffer
            -- recommendation: set to false if you don't have `tree-sitter` cli installed locally
            auto_install = false,

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>v", -- set to `false` to disable one of the mappings
                    node_incremental = ";",
                    -- scope_incremental = ";",
                    node_decremental = ",",
                },
            },

            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
        }
    },

    -- LSP
    "williamboman/mason-lspconfig.nvim",
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Loading capabilities
            local lspconfig = require("lspconfig")
            local lsp_defaults = lspconfig.util.default_config
            local map = vim.keymap.set
            local api = vim.api
            local lspbuf = vim.lsp.buf

            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())


            -- Mappings for vim diagnostics
            map("n", "s<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Open Float (?)" })
            map("n", "s<leader>wd", vim.diagnostic.setqflist,
                { noremap = true, silent = true, desc = "Add to quickfix list" })
            map("n", "sp", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
            map("n", "sn", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
            map("n", "sl", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Add to loclist" })

            -- Mappings for lsp
            map("n", "sD", lspbuf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
            map("n", "sgd", lspbuf.definition, { noremap = true, silent = true, desc = "Go to definition" })
            map("n", "sh", lspbuf.hover, { noremap = true, silent = true, desc = "Hover" })
            map("n", "si", lspbuf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
            map("n", "s<leader>h", lspbuf.signature_help, { noremap = true, silent = true, desc = "Signature help" })
            map("n", "s<leader>ws", lspbuf.workspace_symbol,
                { noremap = true, silent = true, desc = "Workspace symbol (?)" })
            map("n", "s+", lspbuf.add_workspace_folder,
                { noremap = true, silent = true, desc = "Add workspace folder (?)" })
            map("n", "s-", lspbuf.remove_workspace_folder,
                { noremap = true, silent = true, desc = "Remove workspace folder (?)" })
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

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                { border = "rounded" })

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
        end
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
        },
    },
    { "scalameta/nvim-metals",  dependencies = { "nvim-lua/plenary.nvim" } },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
            local cmp = require('cmp')

            local select_opts = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    -- REQUIRED - doesn't work without a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_signature_help', keyword_length = 1 },
                    { name = 'nvim_lsp',                keyword_length = 1 },
                    { name = 'buffer',                  keyword_length = 3 },
                    { name = 'path',                    keyword_length = 3 },
                    { name = 'luasnip' },
                }),
                formatting = {
                    -- Order of fields matters
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, item)
                        local max_item_length = 40
                        local menu_icon = {
                            nvim_lsp = 'λ',
                            nvim_lsp_signature_help = 'Σ',
                            luasnip = '⋗',
                            buffer = 'Ω',
                            path = 'Π',
                        }

                        item.menu = menu_icon[entry.source.name]
                        item.abbr = string.sub(item.abbr, 1, max_item_length)
                        return item
                    end,
                },
            })

            -- Use buffer source for `/` and `?`
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                }
            })
        end
    },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- Formatting
    {
        "stevearc/conform.nvim",
        opts = {
            -- Formatters have to be installed manually or through Mason
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format", "ruff_fix" },
                typescript = { "prettierd" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = false,
            },
        },
    },

    -- Linting
    {
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = { "mypy", "ruff" },
                typescript = { "eslint_d" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
                group = lint_augroup,
                pattern = "*",
                callback = function()
                    lint.try_lint()
                end,
            })

            -- local poetry_available = function()
            --     local f = io.open("./.venv/bin/pylint", "r")
            --     if f ~= nil then
            --         io.close(f)
            --         return true
            --     else
            --         return false
            --     end
            -- end

            -- -- Setup 2 : Runs once when opening nvim
            -- if poetry_available() then
            --     lint.linters.pylint.cmd = "poetry"
            --     lint.linters.pylint.args = { "run", "pylint", "-f", "json" }
            -- end
        end
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
    {
        "benlubas/molten-nvim",
        opts = {},
        config = function()
            -- TODOS
            -- Image display support (long + not everything is in the readme)
            -- Finish config quarto-nvim, otter
            --
            -- Features for now :
            -- Can open ipynb with highlighting and execute code as cells then save modified code back to ipynb
            -- Can run code cells in any python file. No need for ipynb except for collaboration
            --
            -- Problems for now :
            -- Can't display images
            -- Linting, formatting and most lsp functions unavailable inside ipynb (quarto-nvim and otter configs not finished)

            -- Molten setup
            local map = vim.keymap.set
            map("n", "ssnr", ":MoltenRestart!<CR>", { desc = "Restart current kernel and delete outputs" })
            map("n", "ssgg", ":MoltenGoto<CR>", { desc = "Go to first cell" })
            map("n", "ssgo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Enter cell's output" })
            map("n", "ssj", ":MoltenNext<CR>", { desc = "Go to next cell" })
            map("n", "ssk", ":MoltenPrev<CR>", { desc = "Go to previous cell" })
            map("n", "ssd", ":MoltenDelete<CR>", { desc = "Delete current cell" })
            map("n", "ssel", ":MoltenEvaluateLine<CR>", { desc = "Evaluate current line" })
            map("n", "ssr", ":MoltenReevaluateCell<CR>", { desc = "Reevaluate current cell" })
            map("n", "ssos", ":MoltenShowOutput<CR>", { desc = "Show output" })
            map("n", "ssoh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
            map("v", "sse", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate current line" })

            -- Initialize a kernel with the same name as the venv
            map("n", "ssi", function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv ~= nil then
                    venv = string.match(venv, "/.+/(.+)") -- getting only the last part of the path
                    vim.cmd(("MoltenInit %s"):format(venv))
                else
                    vim.cmd("MoltenInit python3")
                end
            end, { desc = "Initialize Molten kernel" })

            vim.g.molten_output_virt_lines = true
            -- After installing molten, run :UpdateRemotePlugins

            -- A project's venv needs to have ipykernel installed, then running :
            -- python -m ipykernel install --user --name project_name
            -- While the venv is active

            -- Then kernel has to be init before anything works


            -- Quarto and otter setup (todo)

            map("n", "ssa", require("otter").dev_setup, { desc = "Activate otter" })
            map("n", "ssgd", require("otter").ask_definition,
                { noremap = true, silent = true, desc = "Go to definition" })
            map("n", "sst", require("otter").ask_type_definition,
                { noremap = true, silent = true, desc = "Type definition" })
            map("n", "ssh", require("otter").ask_hover, { noremap = true, silent = true, desc = "Hover" })
            map("n", "ss<leader>r", require("otter").ask_references,
                { noremap = true, silent = true, desc = "See references" })
            map("n", "ssv", require("otter").ask_rename, { noremap = true, silent = true, desc = "Rename" })
            map("n", "ssf", require("otter").ask_format, { noremap = true, silent = true, desc = "Format" })
        end
    },
    "goerz/jupytext.vim",
    "jmbuhr/otter.nvim",
    {
        "quarto-dev/quarto-nvim",
        opts = {
            lspFeatures = {
                languages = { 'python' },
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" }
                },
                completion = {
                    enabled = true,
                },
            },
            codeRunner = {
                enabled = true,
                default_method = 'molten', -- 'molten' or 'slime'
            },
            keymap = {
                hover = 'K',
                definition = 'gd',
                rename = '<leader>lR',
                references = 'gr',
            }
        },
    },
})
