local M = {}

local function post_theme_set()
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
end

function M.set_dark_theme()
	vim.cmd.colorscheme("nightfox")

	vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#719cd6" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#63cdcf" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#81b29a" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f4a261" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#9d79d6" })

	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3c5372" })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3c5372" })
	vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3c5372" })

	vim.api.nvim_set_hl(0, "Visual", { bg = "#3c5372" })

	post_theme_set()
end

function M.set_light_theme()
	vim.cmd.colorscheme("dayfox")

	vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#719cd6" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#63cdcf" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#81b29a" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f4a261" })
	vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#9d79d6" })

	post_theme_set()
end

return M
