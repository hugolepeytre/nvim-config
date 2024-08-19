return {
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Loading capabilities
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config
			local api = vim.api

			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Mappings for vim diagnostics
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

			lspconfig.angularls.setup({})

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
			ensure_installed = { "stylua", "lua_ls", "rust_analyzer", "pylsp" },
		},
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
