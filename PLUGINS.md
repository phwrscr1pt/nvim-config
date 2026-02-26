# Plugins Guide

Complete guide to all plugins in this Neovim configuration.

---

## Plugin Overview

| Plugin | Purpose | Category |
|--------|---------|----------|
| packer.nvim | Plugin manager | Core |
| onedarkpro.nvim | Color theme | Appearance |
| nvim-web-devicons | File icons | Appearance |
| lualine.nvim | Status bar | Appearance |
| nvim-tree.lua | File explorer | Navigation |
| telescope.nvim | Fuzzy finder | Navigation |
| harpoon | Quick file switching | Navigation |
| toggleterm.nvim | Terminal inside Neovim | Terminal |
| lazygit.nvim | Git interface | Git |
| lsp-zero.nvim | LSP setup (easy mode) | Coding |
| mason.nvim | LSP server installer | Coding |
| nvim-cmp | Autocompletion | Coding |
| LuaSnip | Snippets | Coding |
| vim-be-good | Practice Vim motions | Learning |

---

## Appearance Plugins

### onedarkpro.nvim
**What:** Color scheme for Neovim (currently using `onelight` theme)

**Usage:** Automatically applied. To change theme:
```vim
:colorscheme onedark      " Dark theme
:colorscheme onelight     " Light theme
```

---

### nvim-web-devicons
**What:** Adds file type icons throughout Neovim

**Usage:** Automatic - icons appear in:
- File explorer (nvim-tree)
- Status bar (lualine)
- Telescope results

**Requires:** Nerd Font installed in your terminal

---

### lualine.nvim
**What:** Beautiful status bar at the bottom of the screen

**Shows:**
- Current file name and path
- Git branch
- File type
- Cursor position
- Errors/warnings count

**Usage:** Automatic - always visible at bottom

---

## Navigation Plugins

### nvim-tree.lua
**What:** File explorer sidebar (like VS Code)

**Keybindings:**

| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file tree |

**Inside nvim-tree:**

| Key | Action |
|-----|--------|
| `Enter` | Open file |
| `o` | Open file |
| `v` | Open in vertical split |
| `s` | Open in horizontal split |
| `a` | Create new file/folder |
| `d` | Delete file |
| `r` | Rename file |
| `x` | Cut file |
| `c` | Copy file |
| `p` | Paste file |
| `y` | Copy file name |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |
| `R` | Refresh tree |
| `q` | Close tree |
| `H` | Toggle hidden files |
| `?` | Show help |

**Example workflow:**
1. Press `<Space>e` to open file tree
2. Navigate with `j`/`k`
3. Press `Enter` to open file
4. Press `<Space>e` again to close tree

---

### telescope.nvim
**What:** Fuzzy finder for files, text, and more

**Keybindings:**

| Key | Action |
|-----|--------|
| `<C-p>` | Find files (all files) |
| `<Space>f` | Find git files (only tracked) |
| `<Space>ps` | Live grep (search text in files) |

**Inside Telescope:**

| Key | Action |
|-----|--------|
| `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<CR>` | Open selected |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<Esc>` | Close telescope |
| `<C-c>` | Close telescope |

**Example workflows:**

*Find a file:*
1. Press `<C-p>`
2. Type part of filename
3. Press `Enter` to open

*Search for text in project:*
1. Press `<Space>ps`
2. Type search term
3. Navigate results with `<C-n>`/`<C-p>`
4. Press `Enter` to open file at that line

**Pro tip:** You don't need to type exact matches. Type `useco` to find `UserController.py`

---

### harpoon
**What:** Bookmark files for instant switching (by ThePrimeagen)

**Why use it:** Faster than telescope for files you use constantly

**Keybindings:**

| Key | Action |
|-----|--------|
| `<Space>a` | Add current file to harpoon |
| `<Space>h` | Open harpoon menu |
| `<Tab>` | Go to next harpoon file |
| `<S-Tab>` | Go to previous harpoon file |
| `<A-1>` | Jump to harpoon file 1 |
| `<A-2>` | Jump to harpoon file 2 |
| `<A-3>` | Jump to harpoon file 3 |
| `<A-4>` | Jump to harpoon file 4 |

**Inside harpoon menu:**

| Key | Action |
|-----|--------|
| `Enter` | Open selected file |
| `d` | Remove file from list |
| `q` | Close menu |
| `j`/`k` | Navigate list |

**Example workflow:**
1. Open your main files
2. Press `<Space>a` on each to add to harpoon
3. Now use `<A-1>`, `<A-2>`, etc. to instantly switch
4. Use `<Tab>` to cycle through them

**Best for:** 3-5 files you're actively working on

---

## Terminal Plugin

### toggleterm.nvim
**What:** Terminal emulator inside Neovim

**Keybindings:**

| Key | Mode | Action |
|-----|------|--------|
| `<A-q>` | Normal/Terminal | Toggle floating terminal |
| `<A-w>` | Normal/Terminal | Toggle horizontal terminal |

**Inside terminal:**
- Same keybindings to toggle off
- Type commands like normal terminal
- `exit` to close terminal

**Example workflows:**

*Run a Python script:*
1. Press `<A-q>` for floating terminal
2. Type `python script.py`
3. Press `<A-q>` to hide (keeps running)

*Run commands while coding:*
1. Press `<A-w>` for horizontal split terminal
2. Run your commands
3. Code in top, terminal at bottom
4. Press `<A-w>` to toggle

**Pro tip:** Terminal state is preserved when hidden

---

## Git Plugin

### lazygit.nvim
**What:** Full Git interface inside Neovim

**Requires:** lazygit installed
```bash
sudo apt install lazygit
# Or: https://github.com/jesseduffield/lazygit#installation
```

**Keybinding:**

| Key | Action |
|-----|--------|
| `<Space>gg` | Open LazyGit |

**Inside LazyGit:**

| Key | Action |
|-----|--------|
| `j`/`k` | Navigate |
| `Enter` | Expand/select |
| `Space` | Stage/unstage file |
| `c` | Commit |
| `p` | Pull |
| `P` | Push |
| `?` | Show all keybindings |
| `q` | Quit |

**Panels:**
- Files (staged/unstaged)
- Branches
- Commits
- Stash

**Example workflow:**
1. Press `<Space>gg`
2. Use `Space` to stage files
3. Press `c` to commit
4. Type message, press `Enter`
5. Press `P` to push
6. Press `q` to return to Neovim

---

## Coding Plugins

### lsp-zero.nvim + mason.nvim + nvim-lspconfig
**What:** Language Server Protocol - gives you IDE features

**Features:**
- Code completion
- Go to definition
- Find references
- Rename symbol
- Error diagnostics
- Auto formatting

**Auto-installed LSP servers:**

| Language | Server | File Types |
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
| `K` | Show hover documentation |
| `<Space>r` | Rename symbol |
| `<Space>la` | Code actions (quick fixes) |
| `<Space>lr` | Find all references |
| `<Space>vd` | Show error/warning details |
| `<Space>vws` | Search workspace symbols |
| `[d` | Go to previous error |
| `]d` | Go to next error |
| `<C-h>` | Signature help (in insert mode) |

**Example workflows:**

*Go to definition:*
1. Put cursor on function/variable
2. Press `gd`
3. Jumps to where it's defined
4. Press `<C-o>` to go back

*Rename a variable everywhere:*
1. Put cursor on variable
2. Press `<Space>r`
3. Type new name
4. Press `Enter` - renamed everywhere!

*Fix an error:*
1. See red underline on code
2. Press `<Space>vd` to see error
3. Press `<Space>la` for quick fixes
4. Select fix with `Enter`

**Mason - LSP Server Manager:**

| Command | Action |
|---------|--------|
| `:Mason` | Open Mason UI |
| `:LspInfo` | Show active LSP |

Inside Mason, press `i` to install a server.

---

### nvim-cmp
**What:** Autocompletion popup

**Keybindings (in insert mode):**

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion manually |
| `<C-n>` | Next suggestion |
| `<C-p>` | Previous suggestion |
| `<CR>` | Accept suggestion |
| `<Esc>` | Close completion |

**Sources:**
- LSP suggestions (functions, variables)
- File paths
- Lua API (for Neovim config)

**Example:**
1. Start typing `pri`
2. Completion shows `print`
3. Press `<CR>` to accept
4. Or press `<C-n>` to see more options

---

### LuaSnip
**What:** Snippet engine (code templates)

**Usage:** Snippets appear in completion menu. Works automatically with nvim-cmp.

---

## Learning Plugin

### vim-be-good
**What:** Game to practice Vim motions

**Start the game:**
```vim
:VimBeGood
```

**Games available:**
- **words** - Delete words quickly
- **lines** - Delete lines quickly
- **hjkl** - Practice basic movement

**How to play:**
1. Type `:VimBeGood`
2. Select a game
3. Follow instructions
4. Try to beat your high score!

**Pro tip:** Play 5-10 minutes daily to improve speed

---

## Plugin Commands Reference

| Command | Plugin | Action |
|---------|--------|--------|
| `:NvimTreeToggle` | nvim-tree | Toggle file tree |
| `:Telescope find_files` | telescope | Find files |
| `:Telescope live_grep` | telescope | Search in files |
| `:LazyGit` | lazygit | Open git interface |
| `:ToggleTerm` | toggleterm | Toggle terminal |
| `:Mason` | mason | Manage LSP servers |
| `:LspInfo` | lspconfig | Show LSP status |
| `:PackerSync` | packer | Update plugins |
| `:PackerStatus` | packer | Show plugin status |
| `:VimBeGood` | vim-be-good | Practice game |

---

## Quick Reference Card

```
FILE NAVIGATION
---------------
<Space>e     File tree
<C-p>        Find files
<Space>f     Find git files
<Space>ps    Search in files

HARPOON (Quick Switch)
----------------------
<Space>a     Add file
<Space>h     Harpoon menu
<Tab>        Next file
<A-1/2/3/4>  Jump to file

TERMINAL
--------
<A-q>        Floating terminal
<A-w>        Horizontal terminal

GIT
---
<Space>gg    LazyGit

LSP (Code Intelligence)
-----------------------
gd           Go to definition
K            Hover docs
<Space>r     Rename
<Space>la    Code actions
<Space>lr    References
[d / ]d      Prev/next error

COMPLETION
----------
<C-Space>    Trigger
<C-n/p>      Navigate
<CR>         Accept
```

---

## Tips for Security Work on Kali

1. **Python scripting:** LSP gives autocomplete for Python libraries
2. **Quick terminal:** `<A-q>` to run exploit scripts
3. **Search codebase:** `<Space>ps` to find strings in source code
4. **Multiple files:** Use harpoon for exploit + payload + config files
5. **Git:** `<Space>gg` to manage your tools repository

---

Happy hacking!
