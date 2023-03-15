-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- Number of cells taken to display tab characters
vim.opt.expandtab = true -- Insert spaces instead of tabs with <</>> and tab		
vim.opt.shiftwidth = 4 -- Whitespace cells to add with >> and tab
vim.opt.softtabstop = 4 -- Whitespace cells to delete with << and backspace

-- Newlines respect the indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Don't wrap lines
vim.opt.wrap = false

-- Don't highlight search, show results of search and substitute incrementally
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.termguicolors = true -- Enables colors ??

vim.opt.scrolloff = 8 -- Always keep 8 lines above and below cursor
vim.opt.signcolumn = "yes" -- Always draw sign colum
vim.opt.colorcolumn = "80" -- Display 80 char line length

-- Switch buffers faster
vim.opt.hidden = true

-- <leader> key
vim.g.mapleader = " "

-- Activate auto-pair fly mode
vim.g.AutoPairsFlyMode = 1
