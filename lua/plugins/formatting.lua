return {
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
}
