return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "mypy", "ruff" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				sql = { "sqlfluff" },
				rust = { "clippy" },
				go = { "golangcilint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = lint_augroup,
				pattern = "*",
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
