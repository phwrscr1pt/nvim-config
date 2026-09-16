### Step 7: Back up any existing config

> **Skip Steps 7 and 8 if you used your platform guide's TL;DR** - it already
> cloned the repo into place. Running Step 7 now would move your working config
> aside and Step 8 would clone a second copy over it.

**Linux / macOS** (timestamped, so re-running it cannot clobber an earlier backup):
```bash
for d in ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
  [ -e "$d" ] && mv "$d" "$d.backup.$(date +%Y%m%d%H%M%S)"
done
```

**Windows:**
```powershell
foreach ($d in "$env:LOCALAPPDATA\nvim", "$env:LOCALAPPDATA\nvim-data", "$env:LOCALAPPDATA\Temp\nvim") {
  if (Test-Path $d) { Rename-Item $d "$(Split-Path $d -Leaf).backup.$(Get-Date -f yyyyMMddHHmmss)" }
}
```

### Step 8: Clone this repository

```bash
git clone https://github.com/phwrscr1pt/nvim-config.git ~/.config/nvim
```

On **Windows** the config directory is `%LOCALAPPDATA%\nvim` instead; clone
somewhere you control and point a junction at it - see
[INSTALL_WINDOWS.md](INSTALL_WINDOWS.md) Step 5.

### Step 9: First launch — lazy.nvim installs everything

```bash
nvim
```

- On first launch **lazy.nvim bootstraps itself** (clones its own repo) and opens
  the **Lazy UI**, installing every plugin automatically. This is normal.
- nvim-treesitter then **compiles parsers** in the background (needs the
  tree-sitter CLI + compiler your platform's install guide installed). Give it a moment.
- When the Lazy UI shows everything installed, quit fully with `:qa`, then reopen
  `nvim`. Now it's ready.
- Later, manage plugins with `:Lazy` (UI) or `:Lazy sync` (install+update+clean).
- To pin plugins to the exact committed versions: `:Lazy restore` (reads
  `lazy-lock.json`).

### Step 10: Verify

Run these inside Neovim:

| Check | Command | Expected |
|-------|---------|----------|
| Plugins | `:Lazy` | All plugins installed, no errors |
| LSP | `:checkhealth vim.lsp` | Shows attached servers (there is no `:LspInfo` on 0.11+) |
| Mason | `:Mason` | Server list; pyright/bashls/gopls/clangd/lua_ls installed |
| Treesitter | `:checkhealth nvim-treesitter` | Nvim 0.12+ OK, parsers installed |
| File finder | `<C-p>` | Telescope opens |
| Live grep | `<Space>ps` | Search prompt (needs ripgrep) |
| File tree | `<Space>e` | nvim-tree opens |
| Terminal | `<A-q>` | Floating terminal |
| Git | `<Space>gg` | lazygit opens |

---

## LSP Servers

Auto-installed via Mason on first launch:

| Language | Server |
|----------|--------|
| Python | pyright |
| Bash | bashls |
| Go | gopls |
| C/C++ | clangd |
| Lua | lua_ls |

Manage with `:Mason` (press `i` to install, `U` to update all).

---

## Troubleshooting

### Treesitter errors on launch (`attempt to index field 'list'`, etc.)
Your Neovim is older than 0.12. Check `nvim --version` — if it's 0.11.x, the
home-directory nvim from your platform's install guide isn't winning on PATH. Confirm with
`command -v nvim` (should be `~/.local/bin/nvim`) and that `~/.local/bin` is
prepended to PATH in your shell rc.

### No syntax highlighting / parsers won't compile
Confirm `tree-sitter --version` and a compiler (`gcc --version`) are on PATH, then
re-run parser install: open a file of that language, or
`:lua require('nvim-treesitter').install({'python'})`. Check
`:checkhealth nvim-treesitter`.

### Plugins didn't install / want a clean slate
```vim
:Lazy sync
```
Or fully reset plugin state (keeps your config, re-installs on next launch):
```bash
rm -rf ~/.local/share/nvim/lazy ~/.local/state/nvim/lazy
nvim   # lazy re-bootstraps and reinstalls
```
On **Windows** both of those collapse to one path:
```powershell
Remove-Item "$env:LOCALAPPDATA\nvim-data\lazy" -Recurse -Force
nvim
```

### LSP not working
```vim
:checkhealth vim.lsp
:Mason
```
Install missing servers from the Mason UI (`i`). Some need base tooling:
```bash
sudo apt install -y python3 python3-pip   # pyright
sudo apt install -y clang                 # clangd (or let Mason fetch it)
sudo apt install -y golang                # gopls
```

### Completion menu looks plain / a "using Lua matcher" warning
blink.cmp couldn't fetch its prebuilt Rust matcher; completion still works via the
Lua fallback. Usually a transient network issue. There is no `build` step to
re-run (the spec defines none) - reopen Neovim with a working network, or
`:Lazy sync`. The absence of the warning is the reliable check.

### Clipboard `<Space>y` / `<Space>P` do nothing
Linux only: the `"+` register needs a provider. On X11 `sudo apt install xclip`
(or xsel), on Wayland `sudo apt install wl-clipboard`. **macOS and Windows need
nothing** - macOS uses the built-in `pbcopy`/`pbpaste`.
Verify with `:checkhealth vim.provider` (the old name without the `vim.` prefix
is gone in 0.12).

### Icons show as boxes/question marks
Install a Nerd Font (see your platform's install guide), set the terminal font
to **"JetBrainsMono Nerd Font Mono"** (**"JetBrainsMono NFM"** on Windows), and
**fully restart the terminal** - on macOS that means Cmd-Q, not a new tab.

### Colors look wrong
```bash
echo $COLORTERM   # want: truecolor
```
Do **not** set `TERM` by hand. On macOS forcing `xterm-256color` adds no truecolor
and actively breaks kitty (`xterm-kitty`) and Ghostty (`xterm-ghostty`).

Terminal.app is 256-colour only - use WezTerm, Ghostty, kitty or iTerm2 instead,
or `:set notermguicolors` to accept the downgrade.

Inside **tmux**, set `default-terminal "tmux-256color"` plus
`set -as terminal-features ",*:RGB"`. The older `screen-256color` advertises no
RGB and silently kills truecolor even in a capable terminal.

---

## Updating

Pull the latest config:
```bash
cd ~/.config/nvim && git pull
```
Update plugins (moves past the lockfile) or pin to it:
```vim
:Lazy sync        " update to latest
:Lazy restore     " pin to lazy-lock.json (match the committed versions)
```
Update LSP servers: `:Mason`, then press `U`.

Update Neovim itself - re-run the install step from your platform's guide
(`brew upgrade neovim` on macOS, `winget upgrade Neovim.Neovim` on Windows).

---

## Uninstall

**Linux / macOS:**
```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
# and, if you installed the user-local Neovim:
rm -rf ~/.local/bin/nvim ~/.local/nvim-linux-x86_64     # or nvim-macos-arm64
```

**Windows** - read the two traps below before running this:
```powershell
# Remove the junction WITHOUT touching what it points at.
$cfg = "$env:LOCALAPPDATA\nvim"
if (Test-Path $cfg) {
  if ((Get-Item $cfg).LinkType -eq 'Junction') { cmd /c rmdir "$cfg" }   # unlinks only
  else { Remove-Item $cfg -Recurse -Force }                              # a real dir: DOES delete your config
}

# These two are real directories, and this IS meant to be total.
Remove-Item "$env:LOCALAPPDATA\nvim-data" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Temp\nvim" -Recurse -Force -ErrorAction SilentlyContinue
winget uninstall --id Neovim.Neovim
```

> **Trap 1.** `Remove-Item <junction> -Force` without `-Recurse` errors with
> *"has children and the Recurse parameter was not specified"*. The obvious fix -
> adding `-Recurse` - makes PowerShell 5.1 recurse **through** the reparse point
> and delete your actual cloned config. Use `cmd /c rmdir` (no `/s`) instead.
>
> **Trap 2.** On Windows the **data and state directories are the same path**
> (`%LOCALAPPDATA%\nvim-data`). Deleting it removes your plugins *and* your
> Mason LSP servers, undo history and Grapple tags together.

---

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (bootstraps lazy.nvim; guards Nvim < 0.11)
├── lazy-lock.json              # Pinned plugin commits (committed)
├── lua/
│   ├── core/
│   │   ├── options.lua         # Vim settings
│   │   └── keymaps.lua         # General keybindings
│   └── plugins/
│       ├── init.lua            # Plugin specs + lazy-load triggers
│       ├── lsp.lua             # Native LSP (mason + vim.lsp + LspAttach)
│       ├── blink.lua           # Completion
│       ├── treesitter.lua      # Syntax + textobjects
│       ├── nvim-tree.lua       # File explorer
│       ├── grapple.lua         # Quick file marks
│       ├── devicons.lua        # File-type icons
│       ├── gitsigns.lua        # Git hunks
│       ├── whichkey.lua        # Keymap discovery
│       ├── project.lua         # Project root + recent
│       ├── lualine.lua         # Status line
│       ├── toggleterm.lua      # Terminal
│       ├── claudecode.lua      # Claude Code (AI)
│       ├── live-preview.lua    # Browser markdown preview
│       └── render-markdown.lua # In-buffer markdown render
├── windows/                    # Neovide file-association scripts (Windows only)
├── .gitattributes              # LF in the repo on every platform
├── .gitignore                  # keeps private-archive filenames out of this public repo
├── SETUP.md                    # This file - shared across all platforms
├── INSTALL_LINUX.md            # Platform install guide
├── INSTALL_MACOS.md            # Platform install guide
├── INSTALL_WINDOWS.md          # Platform install guide
├── KEYBINDINGS.md              # Shortcut reference
└── PLUGINS.md                  # Plugin guide
```

---

## Documentation

### Suggested Learning Order

| Step | File | What You'll Learn | Time |
|------|------|-------------------|------|
| 1 | Your platform's install guide, then **SETUP.md** (this file) | Setup and configuration | 15 min |
| 2 | [VIM_TUTORIAL.md](VIM_TUTORIAL.md) | Core Vim motions and commands | 1-2 hours |
| 3 | [KEYBINDINGS.md](KEYBINDINGS.md) | This config's shortcuts (keep open while practicing) | Reference |
| 3b | [VIM_TEXT_OBJECTS.md](VIM_TEXT_OBJECTS.md) | Text objects: the biggest single speed-up | 30 min |
| 4 | [PLUGINS.md](PLUGINS.md) | File navigation, LSP, Git integration | 30 min |
| 5 | [TMUX_TUTORIAL.md](TMUX_TUTORIAL.md) | Terminal multiplexing | 30 min |
| 6 | [VI_MODE_MANUAL.md](VI_MODE_MANUAL.md) | Vi mode in shell and other tools | 15 min |

Thai readers: [NVIM_GUIDE_TH.md](NVIM_GUIDE_TH.md) is the long-form guide, and
[VIM_PRACTICE_TH.md](VIM_PRACTICE_TH.md) is a hands-on drill playground.

---

Happy coding!
