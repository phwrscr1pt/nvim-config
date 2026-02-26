-- Leader key (must be set before plugins)
vim.g.mapleader = " "

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- No backup, persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Misc
vim.opt.isfname:append("@-@")

-- Colorscheme
vim.cmd([[ colorscheme onelight ]])
