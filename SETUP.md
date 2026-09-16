### Step 7: Back up any existing config

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.backup 2>/dev/null
```

### Step 8: Clone this repository

```bash
git clone https://github.com/phwrscr1pt/nvim-config.git ~/.config/nvim
```

### Step 9: First launch — lazy.nvim installs everything

```bash
nvim
```

- On first launch **lazy.nvim bootstraps itself** (clones its own repo) and opens
  the **Lazy UI**, installing every plugin automatically. This is normal.
- nvim-treesitter then **compiles parsers** in the background (needs the
  tree-sitter CLI + compiler from Step 3). Give it a moment.
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
home-directory nvim from Step 2 isn't winning on PATH. Confirm with
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
Lua fallback. Usually a transient network issue — `:Lazy build blink.cmp` retries.

### Clipboard `<Space>y` / `<Space>P` do nothing
The `"+` register needs a provider. On X11: `sudo apt install xclip` (or xsel).
On Wayland: `sudo apt install wl-clipboard`. Verify with `:checkhealth provider`.

### Icons show as boxes/question marks
Install a Nerd Font (Step 6), set the terminal font to "JetBrainsMono Nerd Font
Mono", and **fully restart the terminal**.

### Colors look wrong
```bash
echo $TERM        # want xterm-256color or similar
```
Add `export TERM=xterm-256color` to your shell rc if needed, then restart the
terminal.

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

Update Neovim itself (nightly) — re-run Step 2 (extracting over the old dir is fine).

---

## Uninstall

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
# and, if you installed the user-local Neovim:
rm -rf ~/.local/bin/nvim ~/.local/nvim-linux-x86_64
```

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
│       ├── gitsigns.lua        # Git hunks
│       ├── whichkey.lua        # Keymap discovery
│       ├── project.lua         # Project root + recent
│       ├── lualine.lua         # Status line
│       ├── toggleterm.lua      # Terminal
│       ├── claudecode.lua      # Claude Code (AI)
│       ├── live-preview.lua    # Browser markdown preview
│       └── render-markdown.lua # In-buffer markdown render
├── INSTALL.md                  # This file
├── KEYBINDINGS.md              # Shortcut reference
└── PLUGINS.md                  # Plugin guide
```

---

## Documentation

### Suggested Learning Order

| Step | File | What You'll Learn | Time |
|------|------|-------------------|------|
| 1 | **INSTALL.md** (this file) | Setup and configuration | 15 min |
| 2 | [VIM_TUTORIAL.md](VIM_TUTORIAL.md) | Core Vim motions and commands | 1-2 hours |
| 3 | [KEYBINDINGS.md](KEYBINDINGS.md) | This config's shortcuts (keep open while practicing) | Reference |
| 4 | [PLUGINS.md](PLUGINS.md) | File navigation, LSP, Git integration | 30 min |
| 5 | [TMUX_TUTORIAL.md](TMUX_TUTORIAL.md) | Terminal multiplexing | 30 min |
| 6 | [VI_MODE_MANUAL.md](VI_MODE_MANUAL.md) | Vi mode in shell and other tools | 15 min |

---

Happy coding!
