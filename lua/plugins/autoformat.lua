require("conform").setup({
	-- Formatters have to be installed manually through Mason
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort" },
		javascript = { "prettierd" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
