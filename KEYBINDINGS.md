# Neovim Keybindings Cheatsheet

Quick reference for all keyboard shortcuts in this Neovim configuration.

---

> Leader key: `Space`
>
> Tip: press `Space` (or any prefix like `g`) and pause — **which-key** pops up a
> menu of what can follow. The popup is set to appear after a ~1s pause so quick
> sequences like `dd` don't flash it.

## General

| Keybinding | Mode | Action |
|------------|------|--------|
| `<C-s>` | Normal/Insert | Save file |
| `<A-s>` | Normal | Save file (no autocommand — `:noa w`) |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |
| `<Esc>` | Normal | Clear search highlight + dismiss flash f/t highlight |

## System Clipboard

The `"+` register talks to your OS clipboard. **On macOS and Windows this works
with nothing installed** (macOS uses the built-in `pbcopy`/`pbpaste`). On Linux it
needs a provider — **xclip** or **xsel** (X11), or **wl-clipboard** (Wayland);
without one these do nothing. Check with `:checkhealth vim.provider`.

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>y` | Normal/Visual | Yank to system clipboard |
| `<Space>Y` | Normal | Yank line to system clipboard |
| `<Space>P` | Normal/Visual | Paste from system clipboard |

## Copy File Path

Copies the current buffer's path to the system clipboard (works in any buffer).

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>cp` | Normal | Copy relative path |
| `<Space>cP` | Normal | Copy absolute path |
| `<Space>cn` | Normal | Copy filename only |
| `<Space>cd` | Normal | Copy directory (absolute) |

## File Explorer (nvim-tree)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>e` | Normal | Toggle file tree (find current file) |

Inside nvim-tree:
- `a` - Create. **A trailing `/` is what makes it a folder** — nvim-tree decides
  from the name you type, not from a different key:
  - `notes.md` -> a file
  - `notes/` -> a folder
  - `lua/plugins/new/` -> creates every missing level
  - `lua/plugins/foo.lua` -> creates the missing folders, then the file
- `d` - Delete file
- `r` - Rename file
- `x` / `c` / `p` - Cut / copy / paste
- `y` / `Y` / `gy` - Copy filename / relative path / absolute path
- `Enter` / `o` - Open file
- `<C-v>` / `<C-x>` / `<C-t>` - Open in vertical split / horizontal split / new tab
- `H` - Toggle hidden files
- `g?` - Show help (**the authoritative list** — these are nvim-tree's own keys, not ours)
- `q` - Close tree

## File Search (Telescope)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>f` | Normal | Find files (git-aware: git files in a repo, else all files) |
| `<C-p>` | Normal | Find files (always all files) |
| `<Space>ps` | Normal | Live grep (search text across files — needs ripgrep) |

Inside Telescope:
- `<C-n>` / `<C-p>` - Navigate results
- `<CR>` - Open selected
- `<C-v>` / `<C-x>` / `<C-t>` - Open in vertical split / horizontal split / tab
- `<C-c>` - Close (the picker opens in insert mode; `<Esc>` first drops to normal mode, then `<Esc>` again closes)

## Quick File Marks (Grapple)

Replaces the old Harpoon setup. Grapple tags are grouped per git repository.

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>m` | Normal | Toggle tag for the current file |
| `<Space>M` | Normal | Open the tags menu |

Inside the Grapple menu:
- `<CR>` - Open selected file
- `j` / `k` - Navigate
- edit lines to reorder/remove, then `:w`

## Projects (project.nvim)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>pp` | Normal | Open the recent-projects picker |

Opening a file auto-`cd`s to its project root (detected by `.git`, `package.json`, `go.mod`, `pyproject.toml`, `Makefile`, etc.), so `<Space>f`, `:terminal`, and grep all follow the project.

## Jump Motion (flash.nvim)

| Keybinding | Mode | Action |
|------------|------|--------|
| `s` | Normal/Visual/Op | Flash jump — type target chars, then a label to teleport |
| `S` | Normal/Visual/Op | Flash Treesitter — select by syntax node |

`f` / `F` / `t` / `T` are also enhanced to work across lines. Press `<Esc>` to
clear the leftover highlight.

## Surround (mini.surround)

Moved to a `gs` prefix because flash owns `s`.

| Keybinding | Mode | Action |
|------------|------|--------|
| `gsa` | Normal/Visual | Add surrounding (e.g. `gsaiw"` wraps a word in quotes) |
| `gsd` | Normal | Delete surrounding (e.g. `gsd"`) |
| `gsr` | Normal | Replace surrounding (e.g. `gsr"'` turns `"` into `'`) |
| `gsf` / `gsF` | Normal | Find surrounding right / left |
| `gsh` | Normal | Highlight surrounding |

## Treesitter Text Objects

Structure-aware selections and motions (need the parser for that language).

| Keybinding | Mode | Action |
|------------|------|--------|
| `af` / `if` | Visual/Op | Around / inside function (e.g. `vif`, `daf`) |
| `ac` / `ic` | Visual/Op | Around / inside class |
| `]f` / `[f` | Normal | Jump to next / previous function |

## Terminal (ToggleTerm)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<A-w>` | Normal/Terminal | Toggle horizontal terminal |
| `<A-q>` | Normal/Terminal | Toggle floating terminal |
| `<C-\>` | Normal | Toggle floating terminal (alias; works when `<A-*>` does not) |

On Linux and macOS the terminal uses your `$SHELL` (zsh is the default on both
Kali and macOS); on Windows it prefers `pwsh` and falls back to `powershell`.
Inside the terminal, press the same key to toggle it off, or type `exit`.

Inside any terminal buffer, `<C-\><C-n>` leaves terminal mode. `<C-\>` alone is
mapped in **normal** mode only, precisely so that keeps working.

## Git Hunks (gitsigns)

In-buffer staging/preview, complementing lazygit.

| Keybinding | Mode | Action |
|------------|------|--------|
| `]c` / `[c` | Normal | Next / previous changed hunk (falls back to diff nav in diff mode) |
| `<Space>hs` | Normal | Stage hunk |
| `<Space>hr` | Normal | Reset hunk |
| `<Space>hp` | Normal | Preview hunk |
| `<Space>hb` | Normal | Blame current line (full) |
| `<Space>hd` | Normal | Diff this file |

## Git UI (LazyGit)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>gg` | Normal | Open LazyGit |

## LSP (Code Intelligence)

Neovim 0.11+ ships some LSP defaults on attach (`grn` rename, `gra` code action,
`grr` references, `gri` implementation, `gO` document symbols). This config adds:

| Keybinding | Mode | Action |
|------------|------|--------|
| `gd` | Normal | Go to definition |
| `K` | Normal | Hover documentation |
| `<Space>r` | Normal | Rename symbol |
| `<Space>la` | Normal | Code actions (quick fixes) |
| `<Space>lr` | Normal | Find references |
| `<Space>vd` | Normal | Show line diagnostics (float) |
| `<Space>vs` | Normal | Document symbols (Telescope) |
| `<Space>vws` | Normal | Search workspace symbols |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<C-h>` | Insert | Signature help |

## Autocompletion (blink.cmp)

Replaces nvim-cmp. Uses the "enter" preset.

| Keybinding | Mode | Action |
|------------|------|--------|
| `<C-Space>` | Insert | Trigger / toggle completion menu & docs |
| `<C-n>` / `<C-p>` | Insert | Next / previous item (also `Up`/`Down`) |
| `<CR>` | Insert | Accept selected item |
| `<C-e>` | Insert | Cancel / close the menu |

## Comments

Native Neovim commenting (built in, no plugin).

| Keybinding | Mode | Action |
|------------|------|--------|
| `gc{motion}` | Normal | Toggle comment over a motion |
| `gcc` | Normal | Toggle comment on the current line |
| `gc` | Visual | Toggle comment on the selection |

## AI (Claude Code)

Requires the `claude` CLI on your PATH.

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>ac` | Normal | Toggle / focus the Claude terminal |
| `<Space>ab` | Normal | Add current buffer to context |
| `<Space>as` | Visual | Send selection to Claude |
| `<Space>aa` | Normal | Accept the proposed diff |
| `<Space>ad` | Normal | Reject the proposed diff |

## Markdown

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>op` | Normal | Preview in a real browser (live reload) |
| `<Space>oc` | Normal | Stop the browser preview |
| `<Space>or` | Normal | Toggle in-buffer markdown rendering |

## Tips

1. **Quick Python scripting**: `<C-p>` to open a file, LSP provides autocomplete.
2. **Search in project**: `<Space>ps` to grep across all files.
3. **Terminal workflow**: `<A-q>` for a floating terminal to run scripts.
4. **Fast file switching**: tag your working files with `<Space>m`, jump via `<Space>M`.
5. **Jump anywhere on screen**: `s` + target characters + label (flash).
6. **Text objects beat motions**: `ciw`, `ci"`, `vif` change far more per keystroke
   than `w`/`b` ever will - see [VIM_TEXT_OBJECTS.md](VIM_TEXT_OBJECTS.md).

### Platform notes

| | Linux | macOS | Windows |
|---|---|---|---|
| Clipboard `<Space>y` / `<Space>P` | needs xclip / xsel / wl-clipboard | works out of the box (pbcopy) | works out of the box |
| Terminal shell (`<A-w>` / `<A-q>`) | your `$SHELL` | your `$SHELL` (zsh) | pwsh, else powershell |
| `<A-*>` keys | work | **need Option-as-Meta**, and do not fire at all while a Thai input source is active - use `<C-\>` for the float terminal | work |
| `<C-Space>` completion trigger | works | claimed by the OS for input-source switching | arrives as `<Nul>`, which is mapped |

**Cmd is not available to terminal Neovim on macOS.** Cmd-C / Cmd-V / Cmd-S are
handled by the terminal app and never reach Neovim; the equivalents here are
`<Space>y` / `<Space>P` and `<C-s>`.

## Practice Exercises

### Exercise 1: File Navigation
1. Open Neovim in a project folder: `nvim .`
2. Toggle file tree: `<Space>e`
3. Navigate and open a file with `Enter`
4. Close the tree: `<Space>e`
5. Find another file: `<C-p>` and type part of the filename
6. Search for text in project: `<Space>ps` and type a keyword

### Exercise 2: Grapple Workflow
1. Open 3-4 files you work with often
2. Tag each with `<Space>m`
3. Open the tags menu with `<Space>M`
4. Jump between tagged files from the menu

### Exercise 3: Terminal Integration
1. Open floating terminal: `<A-q>`
2. Run a command (e.g. `ls` or `python --version`)
3. Hide terminal: `<A-q>`
4. Open horizontal terminal: `<A-w>`
5. Toggle it off: `<A-w>`

### Exercise 4: LSP Features
1. Open a Python or Lua file
2. Hover over a function: press `K` to see docs
3. Go to a definition: `gd`
4. Go back: `<C-o>`
5. Find all references: `<Space>lr`
6. Rename a variable: `<Space>r`

### Exercise 5: Complete Workflow
1. `<C-p>` to find and open a file
2. `<Space>m` to tag it
3. `gd` to jump to a definition
4. `<Space>ps` to search for related code
5. `<A-q>` to open a terminal and run tests
6. `<Space>gg` to commit your changes

## Legend

| Symbol | Key |
|--------|-----|
| `<C-x>` | Ctrl + x |
| `<A-x>` | Alt + x (macOS: Option/Cmd-less ⌥ — needs Option-as-Meta, see your install guide) |
| `<S-x>` | Shift + x |
| `<Space>` | Space bar (Leader) |
| `<CR>` | Enter |
| `<Esc>` | Escape |
| `Op` | Operator-pending (after `d`, `y`, `c`, `v`…) |
| Cmd / ⌘ | **Not available to terminal Neovim.** The terminal app handles ⌘C/⌘V/⌘S; use `<Space>y` / `<Space>P` / `<C-s>` |

---

Happy editing!
