-- blink.cmp — completion (replaces nvim-cmp + cmp-nvim-lsp). Batteries-included:
-- built-in lsp/path/snippets/buffer sources and a fuzzy matcher, using native
-- vim.snippet. Version is pinned to 1.* in the spec so lazy downloads a prebuilt
-- matcher binary (no Rust toolchain needed on Windows).
require("blink.cmp").setup({
  -- 'enter' preset: <CR> accepts the selection, <C-n>/<C-p> (or Up/Down) select,
  -- <C-Space> opens the menu, <C-e> cancels -- close to the old nvim-cmp keys.
  -- Terminals (incl. Windows Terminal) deliver Ctrl+Space to Neovim as <Nul>
  -- (^@), so blink's preset <C-space> never fires. Map <Nul> to "show" too, so
  -- the manual Ctrl+Space trigger works in the terminal.
  keymap = {
    preset = "enter",
    ["<Nul>"] = { "show", "show_documentation", "hide_documentation" },
  },

  appearance = { nerd_font_variant = "mono" },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  -- Try the Rust matcher; fall back to the Lua one (with a warning) if the
  -- prebuilt binary can't be fetched on this machine. Completion works either way.
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
