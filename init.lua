-- This config targets Neovim 0.11+ (native vim.lsp.config / vim.lsp.enable) and
-- really wants 0.12 for nvim-treesitter's `main` branch. A distro package
-- manager's `neovim` is often far older, which fails in confusing ways
-- (nil vim.lsp.config, treesitter errors). Fail loudly and early instead.
if vim.fn.has("nvim-0.11") == 0 then
  local v = vim.version()
  vim.api.nvim_echo({
    { "nvim-config: needs Neovim 0.11+ (0.12 recommended), found "
      .. v.major .. "." .. v.minor .. "." .. v.patch .. "\n", "ErrorMsg" },
    { "Your package manager may ship an older Neovim. Install an official build instead:\n" },
    { "  (macOS: brew install neovim | Linux/Windows: the releases page below)\n" },
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
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
  -- Without this, a failed clone surfaces later as an opaque
  -- "module 'lazy' not found". Fail here, where the cause is visible.
  if vim.v.shell_error ~= 0 then
    vim.fn.delete(lazypath, "rf")   -- so the NEXT launch retries the clone cleanly
    vim.api.nvim_echo({
      { "nvim-config: failed to clone lazy.nvim into " .. lazypath .. "\n", "ErrorMsg" },
      { out .. "\n" },
      { "Check that `git` works and you have network access, then restart Neovim.\n", "WarningMsg" },
    }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load the plugin specs from lua/plugins/init.lua, then install + configure them.
require("lazy").setup(require("plugins"))
