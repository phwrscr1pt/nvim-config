require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onelight',
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    }
  }
}
