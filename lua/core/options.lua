-- Leader key (must be set before plugins)
vim.g.mapleader = " "

-- Disable netrw at startup. nvim-tree is lazy-loaded, so netrw must be
-- disabled here (early) rather than in the tree config which now loads on demand.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- No backup, persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Appearance
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Neovide (GUI). NOTE: this block is a WINDOWS workaround and is inert everywhere
-- else (it only fires under Neovide). Linux terminals (kitty/alacritty/gnome-terminal)
-- and macOS terminals (WezTerm/CoreText) shape Thai correctly, so you do NOT need
-- Neovide on Kali or on the Mac.
-- Windows Terminal AtlasEngine cannot shape Thai combining marks
-- (สระ/วรรณยุกต์ = Unicode Mn) without sideways drift/jitter, so Thai-heavy work is
-- done in Neovide, which draws properly shaped glyphs. Noto Sans Thai carries real
-- GPOS mark anchors (Tlwg Mono's are crude), so marks sit correctly. JetBrainsMono
-- NFM stays the primary face (Latin + Nerd Font icons); Thai falls back to Noto.
-- Guarded by vim.g.neovide so the terminal TUI is never touched.
-- Trade-off: Noto is proportional, so `|`-tables won't grid-align — read Thai
-- tables via the browser preview (<leader>op) instead.
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono NFM,Noto Sans Thai:h11"
  -- Neovide applies one font size to every font in `guifont` (Latin + the Thai
  -- fallback share `:h11`), so shrinking the UI is done with a global scale
  -- factor, not a per-font size. 0.9 renders everything at 90%; live-tweak with
  -- `:lua vim.g.neovide_scale_factor = N` and copy the value you like here.
  vim.g.neovide_scale_factor = 0.9
  -- macOS/Neovide: left Option acts as Meta so <A-w>/<A-q>/<A-s> work; right
  -- Option still composes. Inert on Windows/Linux and in every terminal, and
  -- a no-op in WezTerm (left-Option-as-Meta is already its default).
  -- Confirm the spelling on the Mac with :h neovide-settings (the older name
  -- was neovide_input_macos_alt_is_meta, a boolean).
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
end

-- Misc
vim.opt.isfname:append("@-@")

-- When Neovim is launched on a directory (e.g. `nvim .` or `nvim ~/proj`),
-- cd into it and open the file tree instead of showing an empty buffer.
-- netrw is disabled and nvim-tree is lazy-loaded, so nothing handles a directory
-- argument by default. NvimTreeOpen is a lazy `cmd` trigger, so this loads
-- nvim-tree on demand and roots it at the directory you opened.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      vim.cmd("NvimTreeOpen")
    end
  end,
})
