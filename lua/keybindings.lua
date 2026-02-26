vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-s>", ":noa w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

vim.cmd([[ colorscheme onelight ]])

vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")

vim.keymap.set("n", "<A-w>", "<Cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("t", "<A-w>", "<Cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("n", "<A-q>", "<Cmd>ToggleTerm direction=float<CR>")
vim.keymap.set("t", "<A-q>", "<Cmd>ToggleTerm direction=float<CR>")



