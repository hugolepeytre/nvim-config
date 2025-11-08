return {
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Loading capabilities
			local api = vim.api

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Mappings for vim diagnostics
			vim.lsp.config("pylsp", {
				capabilities = capabilities,
				filetypes = { "py" },
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

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
				filetypes = { "lua" },
			})

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
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
							enable = true,
						},
						check = {
							command = "clippy",
						},
					},
				},
			})

			vim.lsp.enable({ "pylsp", "lua_ls", "ts_ls", "rust_analyzer" })
			-- vim.lsp.enable("angularls")

			vim.diagnostic.config({
				virtual_text = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "stylua", "lua_language_server", "rust-analyzer" },
		},
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
