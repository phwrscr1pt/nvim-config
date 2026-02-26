vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  renderer = {
    icons = {
      glyphs = {
        default = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
        },
        git = {
          unstaged = "",
          staged = "",
          deleted = "",
          untracked = "",
        },
      },
    },
  },
})

vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')
