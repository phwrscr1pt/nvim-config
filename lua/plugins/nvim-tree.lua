require('nvim-tree').setup({
  -- Keep the tree root in sync with the cwd, so switching projects (project.nvim
  -- changes the global cwd) re-roots the tree at the new project.
  sync_root_with_cwd = true,
  -- git can spawn slowly (Windows: OneDrive sync / antivirus / the git.exe
  -- wrapper; Linux: big repos on slow disks), and nvim-tree's default 400ms
  -- When it does, vim.system():wait() returns nil inside a scheduled callback
  -- and nvim-tree crashes (git/utils.lua:29 "attempt to index local 'obj'").
  -- Giving git more time lets the check finish before the timeout.
  git = {
    enable = true,
    timeout = 5000,
  },
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
