require("toggleterm").setup()

vim.keymap.set("n", "<A-w>", "<Cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("t", "<A-w>", "<Cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("n", "<A-q>", "<Cmd>ToggleTerm direction=float<CR>")
vim.keymap.set("t", "<A-q>", "<Cmd>ToggleTerm direction=float<CR>")
