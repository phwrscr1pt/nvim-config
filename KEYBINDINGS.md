# Neovim Keybindings Cheatsheet

> Leader key: `Space`

## General

| Keybinding | Mode | Action |
|------------|------|--------|
| `<C-s>` | Normal/Insert | Save file |
| `<A-s>` | Normal | Save file (no autocommand) |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |

## File Explorer (nvim-tree)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>e` | Normal | Toggle file tree |

Inside nvim-tree:
- `a` - Create new file/folder
- `d` - Delete file
- `r` - Rename file
- `Enter` - Open file
- `q` - Close tree

## File Search (Telescope)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<C-p>` | Normal | Find files |
| `<Space>f` | Normal | Find git files |
| `<Space>ps` | Normal | Live grep (search text in files) |

Inside Telescope:
- `<C-n>` / `<C-p>` - Navigate results
- `<CR>` - Open selected
- `<Esc>` - Close

## Quick File Navigation (Harpoon)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>a` | Normal | Add current file to harpoon |
| `<Space>h` | Normal | Toggle harpoon menu |
| `<Tab>` | Normal | Next harpoon file |
| `<S-Tab>` | Normal | Previous harpoon file |
| `<A-1>` | Normal | Jump to harpoon file 1 |
| `<A-2>` | Normal | Jump to harpoon file 2 |
| `<A-3>` | Normal | Jump to harpoon file 3 |
| `<A-4>` | Normal | Jump to harpoon file 4 |

## Terminal (ToggleTerm)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<A-w>` | Normal/Terminal | Toggle horizontal terminal |
| `<A-q>` | Normal/Terminal | Toggle floating terminal |

Inside terminal:
- Same keybindings to toggle off
- Type `exit` to close terminal

## Git (LazyGit)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<Space>gg` | Normal | Open LazyGit |

## LSP (Code Intelligence)

| Keybinding | Mode | Action |
|------------|------|--------|
| `gd` | Normal | Go to definition |
| `K` | Normal | Show hover documentation |
| `<Space>r` | Normal | Rename symbol |
| `<Space>la` | Normal | Code actions (quick fixes) |
| `<Space>lr` | Normal | Find references |
| `<Space>vd` | Normal | Show diagnostics (errors) |
| `<Space>vws` | Normal | Search workspace symbols |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |
| `<C-h>` | Insert | Show signature help |

## Autocompletion (nvim-cmp)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<C-Space>` | Insert | Trigger completion |
| `<C-n>` | Insert | Next completion item |
| `<C-p>` | Insert | Previous completion item |
| `<CR>` | Insert | Confirm selection |

## Tips for Kali Linux

1. **Quick Python scripting**: Open file with `<C-p>`, LSP provides autocomplete
2. **Search in project**: `<Space>ps` to grep across all files
3. **Terminal workflow**: `<A-q>` for floating terminal to run scripts
4. **Fast file switching**: Add frequently used files to Harpoon with `<Space>a`

## Legend

| Symbol | Key |
|--------|-----|
| `<C-x>` | Ctrl + x |
| `<A-x>` | Alt + x |
| `<S-x>` | Shift + x |
| `<Space>` | Space bar (Leader) |
| `<CR>` | Enter |
| `<Esc>` | Escape |
| `<Tab>` | Tab |
