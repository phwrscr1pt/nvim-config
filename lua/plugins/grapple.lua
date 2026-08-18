local grapple = require("grapple")

-- scope = "git": tags are grouped per git repository (falls back to cwd when
-- not in a repo). Grapple stores ABSOLUTE paths, so tags stay correct even when
-- the cwd moves underneath them -- which it does here, because project.nvim
-- auto-cds into each project root.
grapple.setup({
  scope = "git",
})
