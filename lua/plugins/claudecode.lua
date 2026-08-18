-- coder/claudecode.nvim — IDE integration for Anthropic's `claude` CLI.
-- It runs a small WebSocket server that the `claude` CLI auto-connects to (the
-- same protocol the official VS Code / JetBrains extensions use), giving:
--   • current buffer / visual-selection context   (<leader>ab / <leader>as)
--   • native inline diffs with accept / reject     (<leader>aa / <leader>ad)
--   • a toggleable Claude terminal                 (<leader>ac)
--
-- Requires the `claude` CLI on Neovim's PATH (check with `:!which claude` on Linux, `:!where.exe claude` on Windows;
-- restart the terminal after installing the CLI). We use the "native" terminal
-- provider so we don't pull in the heavy snacks.nvim just for the Claude window.
require("claudecode").setup({
  terminal = { provider = "native" },
})
