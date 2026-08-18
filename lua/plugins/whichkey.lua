local wk = require("which-key")

wk.setup({
  -- How long to wait after a keypress before the popup appears (default 200ms).
  -- Raised so quick sequences like `cw` or `dd` don't flash the menu; it only
  -- shows when you actually pause. Bump this higher if it's still too eager.
  delay = 1000,
})

-- Name the leader-key groups so the popup reads clearly. which-key also picks up
-- the `desc` fields already defined on the lazy `keys` specs and the LSP/gitsigns
-- maps automatically, so most entries are labelled without extra work here.
wk.add({
  { "<leader>l", group = "LSP" },
  { "<leader>v", group = "LSP extras" },
  { "<leader>h", group = "Git hunks" },
  { "<leader>a", group = "AI (Claude)" },
  { "<leader>o", group = "Markdown/preview" },
  { "<leader>c", group = "Copy path" },
  { "gs", group = "Surround", mode = { "n", "x" } },
})
