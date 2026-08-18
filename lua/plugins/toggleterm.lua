-- Linux/macOS: `shell` stays nil, so toggleterm uses Neovim's 'shell', i.e. your
-- $SHELL -- zsh on Kali. Nothing to configure.
-- The win32 branch below exists only so this same file still works on Windows,
-- where Neovim's default shell is cmd.exe; there it prefers PowerShell 7 (pwsh)
-- and falls back to Windows PowerShell.
local shell = nil
if vim.fn.has("win32") == 1 then
  shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
end

require("toggleterm").setup({
  shell = shell,
})
