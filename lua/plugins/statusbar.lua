require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				function()
					local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
					local icon =
						require("nvim-web-devicons").get_icon_by_filetype(vim.api.nvim_buf_get_option(0, "filetype"))
					if lsps and #lsps > 0 then
						local names = {}
						for _, lsp in ipairs(lsps) do
							table.insert(names, lsp.name)
						end
						return string.format("%s %s", table.concat(names, ", "), icon)
					else
						return icon or ""
					end
				end,
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
			},
		},
		lualine_c = { "filename" },

		lualine_x = { "diff", "branch" },
		lualine_y = { "aerial", "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { "filename" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
