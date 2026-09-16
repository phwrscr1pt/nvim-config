# Plugins Guide

Complete guide to all plugins in this Neovim configuration.

Plugins are managed by **lazy.nvim** with real lazy-loading: at startup only a
few plugins load eagerly (the colorscheme, nvim-treesitter, and project.nvim —
which need to be ready the instant a file opens); everything else loads on demand
via a keypress, command, event, or filetype. Per-plugin settings live in `lua/plugins/<name>.lua`; the spec (what
triggers each load) lives in `lua/plugins/init.lua`. Versions are pinned in
`lazy-lock.json`, committed so every machine resolves the same commits.

---

## Plugin Overview

| Plugin | Purpose | Category |
|--------|---------|----------|
| lazy.nvim | Plugin manager | Core |
| onedarkpro.nvim | Color theme (onedark) | Appearance |
| nvim-web-devicons | File icons | Appearance |
| lualine.nvim | Status bar | Appearance |
| render-markdown.nvim | In-buffer Markdown rendering | Appearance |
| nvim-tree.lua | File explorer | Navigation |
| telescope.nvim | Fuzzy finder | Navigation |
| grapple.nvim | Quick file marks | Navigation |
| project.nvim | Project root detection + recent projects | Navigation |
| flash.nvim | Label-jump motion | Navigation |
| toggleterm.nvim | Terminal inside Neovim | Terminal |
| lazygit.nvim | Git interface | Git |
| gitsigns.nvim | Git gutter signs + hunk actions | Git |
| nvim-lspconfig | Native LSP client config | Coding |
| mason.nvim + mason-lspconfig.nvim | LSP server installer | Coding |
| blink.cmp | Autocompletion | Coding |
| nvim-treesitter (main) | Syntax highlighting + indent | Coding |
| nvim-treesitter-textobjects | Structure-aware text objects | Coding |
| mini.pairs | Auto-close brackets/quotes | Editing |
| mini.surround | Add/change/delete surroundings | Editing |
| which-key.nvim | Keymap discovery popup | Learning |
| claudecode.nvim | Claude Code (AI) integration | AI |
| live-preview.nvim | Markdown/HTML preview in a browser | Docs |
| vim-be-good | Practice Vim motions | Learning |

> Migrated from the old Packer setup: **packer.nvim → lazy.nvim**,
> **lsp-zero + nvim-cmp + LuaSnip → native LSP + blink.cmp**,
> **harpoon → grapple**, and treesitter/which-key/gitsigns/flash/mini.surround/
> project.nvim were added. `:PackerSync` no longer exists — use `:Lazy`.

---

## Appearance Plugins

### onedarkpro.nvim
**What:** Color scheme. This config loads the **onedark** theme at startup.

```vim
:colorscheme onedark      " current
:colorscheme onelight     " light variant
```

### nvim-web-devicons
**What:** File-type icons in nvim-tree, lualine, and Telescope.
**Requires:** a Nerd Font set in your terminal.

### lualine.nvim
**What:** Status bar at the bottom (`theme = 'auto'`, follows the colorscheme).
**Shows:** file name/path, git branch, filetype, cursor position, diagnostics.

### render-markdown.nvim
**What:** Decorates the *editable* Markdown buffer in place (headings, code
blocks, bullets, table borders) — an in-editor quick-look, not a separate pane.
Reuses the treesitter markdown parser.

| Key | Action |
|-----|--------|
| `<Space>or` | Toggle in-buffer Markdown rendering |

---

## Navigation Plugins

### nvim-tree.lua
**What:** File explorer sidebar.

| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file tree (and find current file) |

**Inside nvim-tree:** `Enter`/`o` open · `<C-v>`/`<C-x>`/`<C-t>` vsplit/split/tab ·
`a` create · `d` delete · `r` rename · `x`/`c`/`p` cut/copy/paste ·
`y`/`Y`/`gy` copy name/relative/absolute · `H` toggle hidden · `R` refresh ·
`q` close · `g?` help.

The tree re-roots itself when project.nvim changes the working directory.

### telescope.nvim
**What:** Fuzzy finder for files, text, symbols, and more.

| Key | Action |
|-----|--------|
| `<Space>f` | Find files (git-aware — git files in a repo, else all files) |
| `<C-p>` | Find files (always all files) |
| `<Space>ps` | Live grep (search text — needs ripgrep) |
| `<Space>pp` | Recent projects (project.nvim extension) |

**Inside Telescope:** `<C-n>`/`<C-p>` navigate · `<CR>` open · `<C-v>`/`<C-x>`/`<C-t>`
vsplit/split/tab · `<C-c>` close (or `<Esc>` twice — the picker starts in insert mode).

**Pro tip:** fuzzy — type `useco` to find `UserController.py`.

### grapple.nvim
**What:** Bookmark files for instant switching (replaces harpoon). Tags are
grouped **per git repository** and stored as absolute paths.

| Key | Action |
|-----|--------|
| `<Space>m` | Toggle tag for the current file |
| `<Space>M` | Open the tags menu |

**Inside the menu:** `<CR>` open · `j`/`k` navigate · edit the lines and `:w` to
reorder or remove. **Best for:** the 3-5 files you're actively working on.

### project.nvim
**What:** Detects a project's root (`.git`, `Makefile`, `package.json`,
`Cargo.toml`, `go.mod`, `pyproject.toml`, `CMakeLists.txt`, …) and auto-`cd`s the
global working directory there, so `<Space>f`, `:terminal`, etc. follow the project.

| Key | Action |
|-----|--------|
| `<Space>pp` | Open the recent-projects picker |

### flash.nvim
**What:** Jump anywhere on screen. Press `s`, type the target characters, then a
one-key label to teleport. Also enhances `f`/`F`/`t`/`T` across lines.

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal/Visual/Op | Flash jump |
| `S` | Normal/Visual/Op | Flash Treesitter (select by syntax node) |

`<Esc>` clears the leftover f/t highlight.

---

## Editing Plugins

### mini.pairs
**What:** Auto-closes brackets and quotes as you type. Loads on insert.

### mini.surround
**What:** Add / change / delete surrounding pairs and tags. Uses a `gs` prefix
(flash owns `s`).

| Key | Action |
|-----|--------|
| `gsa` | Add surrounding (e.g. `gsaiw"`) |
| `gsd` | Delete surrounding (e.g. `gsd"`) |
| `gsr` | Replace surrounding (e.g. `gsr"'`) |
| `gsf` / `gsF` | Find surrounding right / left |
| `gsh` | Highlight surrounding |

---

## Terminal Plugin

### toggleterm.nvim
**What:** Terminal emulator inside Neovim. On Linux and macOS it uses your
`$SHELL` (zsh is the default on both Kali and macOS); on Windows it prefers
`pwsh` and falls back to `powershell`.

| Key | Mode | Action |
|-----|------|--------|
| `<A-q>` | Normal/Terminal | Toggle floating terminal |
| `<A-w>` | Normal/Terminal | Toggle horizontal terminal |
| `<C-\>` | Normal | Toggle floating terminal (alias) |

Terminal state is preserved when hidden.

---

## Git Plugins

### lazygit.nvim
**What:** Full Git TUI inside Neovim. **Requires** the `lazygit` binary.

| Key | Action |
|-----|--------|
| `<Space>gg` | Open LazyGit |

**Inside LazyGit:** `Space` stage/unstage · `c` commit · `p` pull · `P` push ·
`?` all keys · `q` quit.

### gitsigns.nvim
**What:** Change signs in the gutter + in-buffer hunk staging/preview/blame.

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous changed hunk |
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk |
| `<Space>hp` | Preview hunk |
| `<Space>hb` | Blame current line (full) |
| `<Space>hd` | Diff this file |

---

## Coding Plugins

### Native LSP (nvim-lspconfig + mason + mason-lspconfig)
**What:** Language Server Protocol — IDE features. This config uses Neovim's
**native `vim.lsp`** (no lsp-zero). Mason installs the servers; mason-lspconfig
auto-enables them; buffer keymaps attach on `LspAttach`.

**Auto-installed servers:**

| Language | Server | File types |
|----------|--------|------------|
| Python | pyright | `.py` |
| Bash | bashls | `.sh`, `.bash` |
| Go | gopls | `.go` |
| C/C++ | clangd | `.c`, `.cpp`, `.h` |
| Lua | lua_ls | `.lua` |

**Keybindings:**

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<Space>r` | Rename symbol |
| `<Space>la` | Code actions |
| `<Space>lr` | Find references |
| `<Space>vd` | Line diagnostics (float) |
| `<Space>vs` | Document symbols (Telescope) |
| `<Space>vws` | Workspace symbols |
| `[d` / `]d` | Previous / next diagnostic |
| `<C-h>` | Signature help (insert mode) |

Neovim 0.11+ also ships defaults on attach: `grn` rename, `gra` code action,
`grr` references, `gri` implementation, `gO` document symbols.

**Mason:**

| Command | Action |
|---------|--------|
| `:Mason` | Open the Mason UI (press `i` to install, `U` to update) |
| `:checkhealth vim.lsp` | Show attached LSP clients (replaces the old `:LspInfo`) |

### blink.cmp
**What:** Autocompletion (replaces nvim-cmp + LuaSnip). Batteries-included: LSP,
path, snippet, and buffer sources with a fast fuzzy matcher, using native
`vim.snippet`. Pinned to `1.*` so a prebuilt matcher binary is fetched (no Rust
toolchain needed).

| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | Insert | Trigger / toggle the menu & docs |
| `<C-n>` / `<C-p>` | Insert | Next / previous item (also `Up`/`Down`) |
| `<CR>` | Insert | Accept |
| `<C-e>` | Insert | Cancel |

**Sources:** LSP, file paths, snippets, current-buffer words.

### nvim-treesitter (main branch) + textobjects
**What:** Real syntax highlighting and indentation, and structure-aware text
objects. The **main** branch compiles parsers locally, so it needs the
**tree-sitter CLI + a C compiler** (see your platform's install guide).

> **Requires Neovim 0.12+.** The main branch calls 0.12-only APIs; on 0.11 it
> errors on load. Note the config's own gate only checks for 0.11, so a 0.11
> machine loads the config and then fails here. Install a 0.12 build per
> [SETUP.md](SETUP.md) and your platform's install guide.

Parsers kept installed: lua, vim, vimdoc, query, python, bash, go, c, cpp, rust,
markdown, markdown_inline, json, yaml, toml.

**Text objects (from nvim-treesitter-textobjects):**

| Key | Mode | Action |
|-----|------|--------|
| `af` / `if` | Visual/Op | Around / inside function |
| `ac` / `ic` | Visual/Op | Around / inside class |
| `]f` / `[f` | Normal | Next / previous function |

---

## Learning & Discovery

### which-key.nvim
**What:** Press a prefix (`<Space>`, `g`, …) and pause — a popup lists what can
follow, using the `desc` on each mapping. The delay is ~1s so quick sequences
don't flash it.

### vim-be-good
**What:** A game to drill Vim motions.

```vim
:VimBeGood
```

Games: words, lines, hjkl, and more. Play 5-10 minutes daily.

---

## AI & Docs

### claudecode.nvim
**What:** Connects Neovim to the `claude` CLI over the same IDE WebSocket protocol
as the official VS Code extension: selection/buffer context, inline diffs,
accept/reject. **Requires** the `claude` CLI on PATH (`:!which claude`).

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ac` | Normal | Toggle / focus the Claude terminal |
| `<Space>ab` | Normal | Add current buffer to context |
| `<Space>as` | Visual | Send selection |
| `<Space>aa` | Normal | Accept diff |
| `<Space>ad` | Normal | Reject diff |

### live-preview.nvim
**What:** Renders Markdown/HTML in a **real browser** with live reload (like VS
Code's `Ctrl+Shift+V`). Pure Lua — no Node/Deno/build step. Great for tables and
unicode that don't align in the terminal grid.

| Key | Action |
|-----|--------|
| `<Space>op` | Start browser preview of the current file |
| `<Space>oc` | Stop the preview server |

---

## Plugin Commands Reference

| Command | Plugin | Action |
|---------|--------|--------|
| `:Lazy` | lazy.nvim | Open the plugin manager UI |
| `:Lazy sync` | lazy.nvim | Install + update + clean |
| `:Lazy restore` | lazy.nvim | Pin all plugins to `lazy-lock.json` |
| `:Mason` | mason | Manage LSP servers |
| `:checkhealth vim.lsp` | core | Show attached LSP clients |
| `:checkhealth nvim-treesitter` | treesitter | Parser/health status |
| `:NvimTreeFindFileToggle` | nvim-tree | Toggle file tree |
| `:Telescope find_files` | telescope | Find files |
| `:LazyGit` | lazygit | Open git interface |
| `:ToggleTerm` | toggleterm | Toggle terminal |
| `:Grapple toggle` | grapple | Tag/untag current file |
| `:VimBeGood` | vim-be-good | Practice game |

---

## Quick Reference Card

```
FILE NAVIGATION
---------------
<Space>e     File tree
<Space>f     Find files (git-aware)
<C-p>        Find files (all)
<Space>ps    Search in files
<Space>pp    Recent projects

QUICK MARKS (Grapple)
---------------------
<Space>m     Toggle tag
<Space>M     Tags menu

JUMP (flash)
------------
s            Jump to chars + label
S            Jump by syntax node

TERMINAL
--------
<A-q>        Floating terminal
<A-w>        Horizontal terminal

GIT
---
<Space>gg    LazyGit
]c / [c      Next / prev hunk
<Space>hs    Stage hunk
<Space>hp    Preview hunk

LSP (Code Intelligence)
-----------------------
gd           Go to definition
K            Hover docs
<Space>r     Rename
<Space>la    Code actions
<Space>lr    References
[d / ]d      Prev / next diagnostic

COMPLETION (blink.cmp)
----------------------
<C-Space>    Trigger
<C-n/p>      Navigate
<CR>         Accept

SURROUND (gs prefix)
--------------------
gsa " gsd " gsr "'   add/delete/replace
```

---

## Tips for Security Work

1. **Python scripting:** LSP gives autocomplete for Python libraries.
2. **Quick terminal:** `<A-q>` to run exploit scripts.
3. **Search codebase:** `<Space>ps` to find strings in source.
4. **Working set:** tag exploit + payload + config files with `<Space>m`.
5. **Git:** `<Space>gg` to manage your tools repository.

---

Happy hacking!
