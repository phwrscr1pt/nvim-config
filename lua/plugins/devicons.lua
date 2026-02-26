require('nvim-web-devicons').setup {
  -- Override specific file types
  override = {
    -- Example: Change Python icon
    py = {
      icon = "",
      color = "#3776ab",
      name = "Python"
    },
    -- Example: Change Lua icon
    lua = {
      icon = "",
      color = "#51a0cf",
      name = "Lua"
    },
    -- Example: Change shell script icon
    sh = {
      icon = "",
      color = "#89e051",
      name = "Shell"
    },
    -- Example: Change markdown icon
    md = {
      icon = "",
      color = "#519aba",
      name = "Markdown"
    },
  },

  -- Override folder icons (for nvim-tree)
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "GitIgnore"
    },
  },

  -- Default icon for unknown files
  default = true,
}
