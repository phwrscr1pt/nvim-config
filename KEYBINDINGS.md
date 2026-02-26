# Neovim Keybindings Cheatsheet

Quick reference for all keyboard shortcuts in this Neovim configuration.

---

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

## Practice Exercises

### Exercise 1: File Navigation
1. Open Neovim in a project folder: `nvim .`
2. Toggle file tree: `<Space>e`
3. Navigate and open a file with `Enter`
4. Close the tree: `<Space>e`
5. Find another file: `<C-p>` and type part of filename
6. Search for text in project: `<Space>ps` and type a keyword

### Exercise 2: Harpoon Workflow
1. Open 3-4 files you work with often
2. Add each to harpoon: `<Space>a`
3. Open harpoon menu: `<Space>h`
4. Jump between files: `<A-1>`, `<A-2>`, `<A-3>`
5. Cycle through them: `<Tab>` and `<S-Tab>`

### Exercise 3: Terminal Integration
1. Open floating terminal: `<A-q>`
2. Run a command (e.g., `ls` or `python --version`)
3. Hide terminal: `<A-q>`
4. Open horizontal terminal: `<A-w>`
5. Toggle it off: `<A-w>`

### Exercise 4: LSP Features
1. Open a Python or JavaScript file
2. Hover over a function: press `K` to see docs
3. Go to a function definition: `gd`
4. Go back: `<C-o>`
5. Find all references: `<Space>lr`
6. Try renaming a variable: `<Space>r`

### Exercise 5: Complete Workflow
Combine everything:
1. `<C-p>` to find and open a file
2. `<Space>a` to add it to harpoon
3. `gd` to jump to a definition
4. `<Space>ps` to search for related code
5. `<A-q>` to open terminal and run tests
6. `<Space>gg` to commit your changes

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

---

Happy editing!
