local lint = require("lint")

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

local poetry_available = function()
	local f = io.open("./.venv/bin/pylint", "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Setup 1 : Doesn't run when opening nvim but runs at every python file open
-- local pylint_linter = lint.linters.pylint
-- lint.linters.pylint = function()
-- 	if poetry_available() then
-- 		pylint_linter.cmd = "poetry"
-- 		pylint_linter.args = { "run", "pylint", "-f", "json" }
-- 	end
-- 	return pylint_linter
-- end

-- Setup 2 : Runs once when opening nvim
if poetry_available() then
	lint.linters.pylint.cmd = "poetry"
	lint.linters.pylint.args = { "run", "pylint", "-f", "json" }
end