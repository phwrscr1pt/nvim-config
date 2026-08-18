-- project.nvim (DrKJeff16 fork) — auto-cd to a project's root + a recent-projects
-- picker. Maintained continuation of ahmedkhalf/project.nvim, which is
-- unmaintained and errors on Neovim 0.12 (it calls the removed
-- vim.lsp.buf_get_clients). The fork exposes its module as `project`.
local project = require("project")

project.setup({
  manual_mode = false,    -- auto-detect + cd to the project root when you open a file
  scope_chdir = "global", -- change the GLOBAL cwd (so <leader>f, :terminal, etc. follow)
  silent_chdir = true,
  patterns = {
    ".git", ".hg", ".svn",
    "Makefile", "package.json", "Cargo.toml", "go.mod",
    "pyproject.toml", "CMakeLists.txt", ".nvim.lua",
  },
})

-- Recent-projects picker on <leader>pp. Telescope + the "projects" extension are
-- loaded on demand here so Telescope itself stays lazy.
vim.keymap.set("n", "<leader>pp", function()
  require("telescope").load_extension("projects")
  vim.cmd("Telescope projects")
end, { desc = "Projects" })
