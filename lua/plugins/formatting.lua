return {
	{
		"stevearc/conform.nvim",
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)
			conform.formatters.sql_formatter = {
				prepend_args = { "-l", "postgresql" },
			}
		end,
		opts = {
			-- Formatters have to be installed manually or through Mason
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix" },
				typescript = { "prettierd" },
				javascript = { "prettierd" },
				sql = { "sql_formatter" },
				json = { "jq" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
		},
	},
}
