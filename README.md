# nvim-config

A Neovim configuration that runs the same on **Linux, macOS and Windows**.

Neovim **0.12+**, [lazy.nvim](https://github.com/folke/lazy.nvim), native
`vim.lsp`, and nvim-treesitter's `main` branch. Everything except the colorscheme
is lazy-loaded.

> The config's own version gate only checks for 0.11, so a 0.11 machine will load
> it and then fail inside nvim-treesitter. You want 0.12+.

## Install

| Platform | Guide |
|---|---|
| Linux (Kali / Debian) | [INSTALL_LINUX.md](INSTALL_LINUX.md) |
| macOS | [INSTALL_MACOS.md](INSTALL_MACOS.md) · [ฉบับภาษาไทย](INSTALL_MACOS_TH.md) |
| Windows | [INSTALL_WINDOWS.md](INSTALL_WINDOWS.md) |

Each one ends by handing you to **[SETUP.md](SETUP.md)**, which is shared: first
launch, LSP servers, troubleshooting, updating and uninstalling.

## Docs

| File | What |
|---|---|
| [KEYBINDINGS.md](KEYBINDINGS.md) | Every shortcut in this config |
| [PLUGINS.md](PLUGINS.md) | What each plugin does and why it is here |
| [VIM_TUTORIAL.md](VIM_TUTORIAL.md) | Core Vim motions and commands |
| [VIM_TEXT_OBJECTS.md](VIM_TEXT_OBJECTS.md) | Text objects — the biggest single speed-up |
| [TMUX_TUTORIAL.md](TMUX_TUTORIAL.md) | tmux (Linux and macOS) |
| [VI_MODE_MANUAL.md](VI_MODE_MANUAL.md) | Vi mode in your shell and other tools |
| [NVIM_GUIDE_TH.md](NVIM_GUIDE_TH.md) | คู่มือฉบับยาวภาษาไทย |
| [VIM_PRACTICE_TH.md](VIM_PRACTICE_TH.md) | สนามซ้อมคำสั่ง Vim ภาษาไทย |
| [NEOVIDE_TH.md](NEOVIDE_TH.md) | Neovide สำหรับงานภาษาไทยบน Windows |

## Scope

**Neovim only.** Shell config, tmux, terminal emulator settings and OS-level
dotfiles live in a separate private repo, so this one stays a config you can hand
to someone else.

The one exception is `windows/`, which holds the optional Neovide
file-association scripts — they are documented in
[INSTALL_WINDOWS.md](INSTALL_WINDOWS.md) and touch nothing unless you run them.

## Layout

```
init.lua               # entry point; version gate + lazy.nvim bootstrap
lazy-lock.json         # pinned plugin commits, shared across all three machines
lua/core/              # options.lua, keymaps.lua
lua/plugins/           # one file per plugin + init.lua holding the specs
windows/               # Neovide file-association scripts (Windows only, optional)
```

## Working on two machines at once

If a machine runs the config through a symlink or junction, the linked checkout
**is** the live config — editing it changes your editor immediately. If you also
keep a second clone for development, remember that `git pull` in one does not
touch the other, and the drift is silent: you push a keymap change and the other
machine keeps loading the old one with no error. Pull in the linked checkout.

## Credits

This config started from the class repo used in the Bangkok 2026 Neovim class and
has been substantially rewritten since — see `git log` for the history.
