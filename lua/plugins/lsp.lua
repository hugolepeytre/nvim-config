return {
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Loading capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Mappings for vim diagnostics
			vim.lsp.config("pylsp", {
				capabilities = capabilities,
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
			})

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				root_markers = { { "tsconfig.json", "package.json" }, ".git" },
				cmd = { "typescript-language-server", "--stdio", "--log-level", "4" },
			})

			vim.lsp.config("gopls", {
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
					},
				},
				on_attach = function()
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
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

			vim.lsp.enable({ "pylsp", "lua_ls", "ts_ls", "rust_analyzer", "gopls" })
			vim.lsp.log.set_level("warn")

			vim.diagnostic.config({
				jump = { float = true },
				virtual_text = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "stylua", "lua_language_server", "rust-analyzer" },
		},
	},
}
