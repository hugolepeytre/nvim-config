local lint = require("lint")

lint.linters_by_ft = {
	markdown = { "vale" },
	python = { "pylint" },
	lua = { "luacheck" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = lint_augroup,
	pattern = "*",
	callback = function(args)
		lint.try_lint()
	end,
})

require("lint").linters.phpcs.args = {
	"-q",
	-- <- Add a new parameter here
	"--report=json",
	"-",
}
