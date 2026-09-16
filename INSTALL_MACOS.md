<!-- Thai twin: INSTALL_MACOS_TH.md — any edit to a command or fence here needs a matching edit there. -->
# Installation Guide - macOS

Step-by-step guide for a Mac (Apple Silicon assumed; Intel differences are called
out inline). For the other platforms see [INSTALL_LINUX.md](INSTALL_LINUX.md) and
[INSTALL_WINDOWS.md](INSTALL_WINDOWS.md).

> **Important:** this config needs **Neovim 0.12+** (nvim-treesitter's `main`
> branch calls 0.12-only APIs). Homebrew's `neovim` formula tracks upstream
> stable closely, so `brew install neovim` is enough — you do **not** need a
> nightly build or the release tarball. (The config's own gate only checks for
> 0.11, so a 0.11 machine loads it and then fails inside treesitter.)

> **Good news for a Mac:** none of this config's Lua needs changing for macOS.
> The only two platform branches in the whole tree are `vim.fn.has("win32")`
> guards, and both fall back to exactly what macOS wants — your `$SHELL` for the
> embedded terminal, and Apple `clang` for compiling tree-sitter parsers.

---

## TL;DR - Copy-Paste for a Fresh Mac

This is the **complete** install including the clone. If you use it, skip Steps 7
and 8 of [SETUP.md](SETUP.md) (backup + clone — already done) and start at Step 9.

```bash
# 1. Compiler + git. Do this FIRST: a fresh Mac's /usr/bin/git is an Xcode stub
#    that pops a GUI dialog and fails, which would break the plugin bootstrap.
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# 2. Homebrew, and put it on PATH (Apple Silicon; Intel uses /usr/local)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Everything else
brew install neovim ripgrep fd node go lazygit tree-sitter-cli
brew install --cask font-jetbrains-mono-nerd-font

# 4. Verify before going further
nvim --version | head -1     # must be 0.12.0 or later
tree-sitter --version        # must be >= 0.26.1

# 5. Clone this config, then launch — lazy.nvim installs everything on first run
git clone https://github.com/phwrscr1pt/nvim-config.git ~/.config/nvim
nvim
```

---

## Requirements

| Need | Install | Why |
|---|---|---|
| **Neovim 0.12+** | `brew install neovim` | nvim-treesitter `main` |
| **git** | Xcode CLT (above) | lazy.nvim bootstrap + `<Space>f` |
| **C compiler** | Xcode CLT (`clang`) | tree-sitter compiles parsers locally |
| **tree-sitter CLI >= 0.26.1** | `brew install tree-sitter-cli` | parser compilation |
| **ripgrep** | `brew install ripgrep` | `<Space>ps` live grep |
| **fd** *(optional)* | `brew install fd` | faster Telescope file finding |
| **lazygit** | `brew install lazygit` | `<Space>gg` |
| **Node** | `brew install node` | Mason installs pyright + bashls |
| **Go** | `brew install go` | Mason builds gopls |
| **Nerd Font** | `brew install --cask font-jetbrains-mono-nerd-font` | icons in the tree, statusline and completion menu |
| **Clipboard** | *nothing* | macOS uses the built-in `pbcopy`/`pbpaste` |

> **Do not** set `CC` on a Mac. `/usr/bin/gcc` is a clang shim and buys nothing;
> the tree-sitter CLI already defaults to `cc`, which is Apple clang.
> The `vim.env.CC = "gcc"` line in `lua/plugins/treesitter.lua` is `win32`-gated
> and correctly skipped here.

---

## Fresh macOS Installation (Complete Guide)

### Step 1: Xcode Command Line Tools

```bash
xcode-select -p || xcode-select --install   # GUI dialog; wait for it to finish
git --version && clang --version | head -1  # both must answer with NO dialog
```

This is what `build-essential` is on Debian. It provides `git` **and** `cc`.

### Step 2: Homebrew on PATH

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile   # Intel: /usr/local/bin/brew
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Put PATH edits in `~/.zprofile` or `~/.zshrc`, **never `~/.zshenv`** — `/etc/zprofile`
runs `path_helper`, which re-orders PATH and silently undoes a `~/.zshenv` prepend.

This matters because the config shells out to five bare-name binaries with no
absolute path: `git`, `tree-sitter`, `lazygit`, `rg` and `claude`.

### Step 3: Neovim and the rest

```bash
brew info neovim                 # confirm stable is 0.12.x before installing
brew install neovim ripgrep fd node go lazygit tree-sitter-cli
```

Do **not** use `brew install --HEAD neovim` — that compiles from source.

If Homebrew's stable were ever still 0.11.x, use the official macOS build:

```bash
ARCH=$([ "$(uname -m)" = arm64 ] && echo arm64 || echo x86_64)
curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-$ARCH.tar.gz
mkdir -p ~/.local ~/.local/bin
tar -xzf nvim-macos-$ARCH.tar.gz -C ~/.local/ && rm nvim-macos-$ARCH.tar.gz
ln -sf ~/.local/nvim-macos-$ARCH/bin/nvim ~/.local/bin/nvim
grep -q '.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh -l && nvim --version | head -1
```

If you download that tarball with a **browser** instead of curl, run
`xattr -c nvim-macos-$ARCH.tar.gz` first to clear Gatekeeper's quarantine flag.
Via curl it is unnecessary — curl does not set it.

> **Note:** there is no `fdfind` on macOS. The rename in the Linux guide is a
> Debian packaging quirk; Homebrew installs the binary as `fd`.

### Step 4: Nerd Font

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

No `brew tap` is needed — the `homebrew/cask-fonts` tap was folded into
`homebrew/cask` in 2024, and older guides that still say otherwise are stale.

Then set your terminal font to **`JetBrainsMono Nerd Font Mono`** and **quit the
terminal completely with Cmd-Q** — a new tab is not enough, profile fonts are
read at app launch. This is the single most common cause of "I installed the
font and still see boxes".

> The same font is listed as **`JetBrainsMono NFM`** on Windows (what winget
> registers). Searching for the wrong string is why people think it failed to
> install.

Three separate places assume this font: `nerd_font_variant` in
`lua/plugins/blink.lua`, the hardcoded glyphs in `lua/plugins/nvim-tree.lua`, and
the icon overrides in `lua/plugins/devicons.lua`.

### Step 5: Terminal

Terminal.app is 256-colour only, so `termguicolors` produces flattened onedark
and no undercurl on diagnostics. Use one of these instead:

```bash
brew install --cask wezterm      # or: ghostty, kitty
```

> **WezTerm's stable cask is from February 2024.** On a recent macOS you may
> prefer `brew install --cask wezterm@nightly`, which is what most WezTerm users
> actually run.

**Why it matters for the keymaps:** macOS treats Option as a compose key by
default, so `<A-s>` / `<A-w>` / `<A-q>` type `ß` / `∑` / `œ` instead of firing.

| Terminal | Setting |
|---|---|
| **WezTerm** | nothing — left Option already sends Esc+ |
| **Ghostty** | `macos-option-as-alt = left` |
| **kitty** | `macos_option_as_alt left` |
| **iTerm2** | Settings -> Profiles -> Keys -> Left Option key = `Esc+` |
| **Terminal.app** | Settings -> Profiles -> Keyboard -> "Use Option as Meta key" |

Use **left-only** so the right Option still composes é / – / ©.

> **Never** `export TERM=xterm-256color` on macOS. It adds no truecolor and
> actively breaks kitty (`xterm-kitty`) and Ghostty (`xterm-ghostty`).
> Check with `echo $COLORTERM` — you want `truecolor`.

### Step 6: Claude CLI (optional, for `<Space>a*`)

Install per the official docs. The macOS wrinkle: the native installer puts the
launcher in `~/.local/bin`, which is **not** on the default zsh PATH.

```bash
grep -q '.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh -l && claude --version
```

Verify what **Neovim** sees, not what your shell sees: `:echo exepath('claude')`.
An empty string is the tell.

---

**Next:** continue at [SETUP.md](SETUP.md) — it covers the clone, first launch,
LSP servers, troubleshooting, updating and uninstalling for every platform.
If you used the TL;DR above, skip its Steps 7 and 8 and start at Step 9.

---

## macOS-specific gotchas

Ranked by how likely you are to hit them.

1. **Held `j`/`k` crawls.** System Settings -> Keyboard -> Key repeat to Fast,
   Delay until repeat to Short.
2. **`<A-w>` / `<A-q>` / `<A-s>` do nothing while the Thai input source is
   active.** Left-Option+w sends the Thai layout's key, not `^[w`. This is macOS
   input-source behaviour and cannot be fixed in any config file here. Use
   **`<C-\>`** for the float terminal — it is mapped in normal mode precisely for
   this. (`<C-\><C-n>` still leaves terminal mode; `<C-\>` alone is normal-mode only.)
3. **Ctrl+Space stops triggering completion once you add a second input
   source.** macOS binds it to "Select the previous input source". Turn that off
   in System Settings -> Keyboard -> Keyboard Shortcuts -> Input Sources, or map
   another key in your terminal. Completion still auto-shows either way.
4. **Colours look wrong inside tmux even in a good terminal.** Use
   `tmux-256color` plus `set -as terminal-features ",*:RGB"`, not
   `screen-256color`.
5. **Treesitter fails silently** if `tree-sitter` or `cc` is missing from the
   PATH Neovim sees. You keep legacy regex highlighting, so it is easy to miss —
   but `af`/`if`/`ac`/`ic`, `]f`/`[f` and `<Space>or` all quietly stop working.
   Diagnose with `:checkhealth nvim-treesitter`.
6. **Privacy prompts make folders look empty.** The first time your terminal
   touches `~/Desktop`, `~/Documents` or `~/Downloads`, macOS asks permission. If
   denied, directory reads fail and the tree, Telescope and project.nvim all come
   up blank with no error. Check with
   `:lua vim.print(vim.fn.readdir(vim.fn.expand('~/Desktop')))` — not
   `isdirectory()`, which still returns 1. Simplest avoidance: keep projects in
   `~/code`.
7. **No physical Esc key** (2016-2019 Touch Bar MacBook Pro): System Settings ->
   Keyboard -> Keyboard Shortcuts -> Modifier Keys -> Caps Lock = Escape. Worth
   doing on any Mac.
8. **GUI-launched Neovim sees none of your PATH.** An app started from Finder or
   Spotlight inherits launchd's minimal PATH, not `~/.zprofile`. A plain `nvim`
   typed in a terminal is unaffected.

## Things that look like macOS problems but are not

- **The Neovide/Thai block** in `lua/core/options.lua` is a **Windows Terminal**
  workaround. macOS shapes Thai correctly via CoreText and HarfBuzz, so you do
  **not** need Neovide here — and you avoid its proportional-font table
  misalignment. Keep `cell = "raw"` in `lua/plugins/render-markdown.lua` though:
  that fixes width maths inside the plugin's own Lua and is platform-independent.
- **xclip / xsel / wl-clipboard** — Linux-only. Nothing to install.
  Verify with `:checkhealth vim.provider`.
- **Mason's clangd on Apple Silicon** is a universal binary with a native arm64
  slice. No Rosetta anywhere in this stack.
- **`<C-s>` is not eaten by flow control.** Neovim's TUI clears IXON, so Ctrl+S
  saves normally.
