-- This config targets Neovim 0.11+ (native vim.lsp.config / vim.lsp.enable) and
-- really wants 0.12 for nvim-treesitter's `main` branch. Debian/Kali's apt
-- `neovim` package is typically far older, which fails in confusing ways
-- (nil vim.lsp.config, treesitter errors). Fail loudly and early instead.
if vim.fn.has("nvim-0.11") == 0 then
  local v = vim.version()
  vim.api.nvim_echo({
    { "nvim-config: needs Neovim 0.11+ (0.12 recommended), found "
      .. v.major .. "." .. v.minor .. "." .. v.patch .. "\n", "ErrorMsg" },
    { "Kali/Debian apt ships an older Neovim. Install an official build instead:\n" },
    { "  https://github.com/neovim/neovim/releases/latest\n" },
    { "Config not loaded.\n", "WarningMsg" },
  }, true, {})
  return
end

-- Core settings (load first)
require("core.options")
require("core.keymaps")

-- Bootstrap lazy.nvim (plugin manager) if it isn't installed yet.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load the plugin specs from lua/plugins/init.lua, then install + configure them.
require("lazy").setup(require("plugins"))
