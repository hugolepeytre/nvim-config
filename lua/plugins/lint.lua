local lint = require("lint")

-- TODO : Doesn't seem to work well for now. It runs though
lint.linters_by_ft = {
	python = { "pylint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = lint_augroup,
	pattern = "*",
	callback = function()
		lint.try_lint()
	end,
})

-- Add options when running the linters
-- require("lint").linters.phpcs.args = {
-- 	"-q",
-- 	-- <- Add a new parameter here
-- 	"--report=json",
-- 	"-",
-- }
