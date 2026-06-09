# VS Code Vim Setup Session Log

**Date:** 2026-06-09

This document records everything we did to set up Vim in VS Code.

---

## Overview

We set up **VSCodeVim** extension in VS Code and configured it to match your existing Neovim keybindings from your Kali VM config.

---

## What We Did

### 1. Research Phase

- Compared two options for Vim in VS Code:
  - **VSCodeVim** - Vim emulator (chosen)
  - **VSCode Neovim** - Uses real Neovim backend
- Chose VSCodeVim for simplicity and native VS Code integration

### 2. Installed VSCodeVim Extension

- Extension: **Vim** by vscodevim
- Install via: `Ctrl+Shift+X` → Search "Vim" → Install

### 3. Ported Keybindings from Neovim Config

Read your existing nvim keybindings from:
- `C:\Users\pkhyo\nvim-config-class-bkk-2026\lua\core\keymaps.lua`
- `C:\Users\pkhyo\nvim-config-class-bkk-2026\lua\plugins\telescope.lua`
- `C:\Users\pkhyo\nvim-config-class-bkk-2026\lua\plugins\harpoon.lua`
- `C:\Users\pkhyo\nvim-config-class-bkk-2026\lua\plugins\nvim-tree.lua`
- `C:\Users\pkhyo\nvim-config-class-bkk-2026\lua\plugins\toggleterm.lua`

### 4. Modified VS Code Settings

**File:** `C:\Users\pkhyo\AppData\Roaming\Code\User\settings.json`

Added the following Vim settings:

```json
// ===== VSCodeVim Settings =====
"vim.easymotion": true,
"vim.incsearch": true,
"vim.useSystemClipboard": true,
"vim.hlsearch": true,
"vim.leader": "<space>",
"vim.surround": true,
"extensions.experimental.affinity": { "vscodevim.vim": 1 },

"vim.normalModeKeyBindingsNonRecursive": [
    { "before": ["<leader>", "?"], "commands": ["workbench.action.openGlobalKeybindings"] },
    { "before": ["<leader>", "k"], "commands": [{ "command": "vscode.open", "args": "C:\\Users\\pkhyo\\nvim-config-class-bkk-2026\\VSCODE_VIM_CHEATSHEET.md" }] },
    { "before": ["<C-s>"], "commands": [":w"] },
    { "before": ["<A-s>"], "commands": [":w"] },
    { "before": ["<leader>", "e"], "commands": ["workbench.view.explorer"] },
    { "before": ["<C-p>"], "commands": ["workbench.action.quickOpen"] },
    { "before": ["<leader>", "f"], "commands": ["workbench.action.quickOpen"] },
    { "before": ["<leader>", "p", "s"], "commands": ["workbench.action.findInFiles"] },
    { "before": ["<leader>", "g", "g"], "commands": ["workbench.view.scm"] },
    { "before": ["<A-q>"], "commands": ["workbench.action.terminal.toggleTerminal"] },
    { "before": ["<A-w>"], "commands": ["workbench.action.terminal.toggleTerminal"] },
    { "before": ["<leader>", "h"], "commands": ["workbench.action.showAllEditors"] },
    { "before": ["<leader>", "a"], "commands": ["workbench.action.pinEditor"] },
    { "before": ["<A-1>"], "commands": ["workbench.action.openEditorAtIndex1"] },
    { "before": ["<A-2>"], "commands": ["workbench.action.openEditorAtIndex2"] },
    { "before": ["<A-3>"], "commands": ["workbench.action.openEditorAtIndex3"] },
    { "before": ["<A-4>"], "commands": ["workbench.action.openEditorAtIndex4"] },
    { "before": ["<tab>"], "commands": [":tabnext"] },
    { "before": ["<S-tab>"], "commands": [":tabprev"] }
],

"vim.visualModeKeyBindingsNonRecursive": [
    { "before": ["J"], "commands": ["editor.action.moveLinesDownAction"] },
    { "before": ["K"], "commands": ["editor.action.moveLinesUpAction"] }
],

"vim.insertModeKeyBindings": [
    { "before": ["<C-s>"], "commands": [":w"] }
]
```

### 5. Created Keybindings.json

**File:** `C:\Users\pkhyo\AppData\Roaming\Code\User\keybindings.json`

```json
[
    {
        "key": "ctrl+shift+k",
        "command": "vscode.open",
        "args": "C:\\Users\\pkhyo\\nvim-config-class-bkk-2026\\VSCODE_VIM_CHEATSHEET.md"
    }
]
```

### 6. Created Cheatsheet

**File:** `C:\Users\pkhyo\nvim-config-class-bkk-2026\VSCODE_VIM_CHEATSHEET.md`

A comprehensive Vim cheatsheet for VS Code including:
- Custom keybindings
- Essential Vim motions
- Text objects
- VS Code LSP commands
- EasyMotion and Surround commands
- Quick reference card

---

## Files Created/Modified

| File | Action |
|------|--------|
| `C:\Users\pkhyo\AppData\Roaming\Code\User\settings.json` | Modified - Added Vim settings |
| `C:\Users\pkhyo\AppData\Roaming\Code\User\keybindings.json` | Created - Added Ctrl+Shift+K |
| `C:\Users\pkhyo\nvim-config-class-bkk-2026\VSCODE_VIM_CHEATSHEET.md` | Created - Vim cheatsheet |
| `C:\Users\pkhyo\nvim-config-class-bkk-2026\VSCODE_VIM_SETUP_LOG.md` | Created - This file |

---

## Your Custom Keybindings Summary

| Nvim Keybinding | VS Code Keybinding | Action |
|-----------------|-------------------|--------|
| `<C-s>` | `Ctrl+S` | Save file |
| `<A-s>` | `Alt+S` | Save file |
| `<leader>e` | `Space e` | File explorer |
| `<C-p>` | `Ctrl+P` | Find files |
| `<leader>f` | `Space f` | Find files |
| `<leader>ps` | `Space p s` | Search in files |
| `<leader>gg` | `Space g g` | Git panel |
| `<A-q>` | `Alt+Q` | Toggle terminal |
| `<A-w>` | `Alt+W` | Toggle terminal |
| `<leader>h` | `Space h` | Show all editors |
| `<leader>a` | `Space a` | Pin editor |
| `<A-1/2/3/4>` | `Alt+1/2/3/4` | Jump to tab |
| `<Tab>` | `Tab` | Next tab |
| `<S-Tab>` | `Shift+Tab` | Previous tab |
| `J` (visual) | `J` (visual) | Move lines down |
| `K` (visual) | `K` (visual) | Move lines up |
| - | `Space ?` | Show keyboard shortcuts |
| - | `Space k` | Open cheatsheet |
| - | `Ctrl+Shift+K` | Open cheatsheet (always works) |

---

## Next Steps

1. **Restart VS Code** - Required for Vim extension to activate
2. **Test Vim** - Press `Esc`, then try `dd` to delete a line
3. **Try your keybindings** - `Space e`, `Space f`, `Alt+Q`, etc.
4. **Open cheatsheet** - `Ctrl+Shift+K` or `Space k`

---

## Troubleshooting

### Vim not working after restart?
- Check extension is enabled: `Ctrl+Shift+X` → Search "Vim" → Should say "Disable" (meaning it's enabled)

### Keybindings not working?
- Make sure you're in Normal mode (press `Esc` first)
- Check if another extension conflicts: `Ctrl+Shift+P` → "Developer: Show Running Extensions"

### Want to disable Vim temporarily?
- `Ctrl+Shift+P` → "Vim: Toggle Vim Mode"

### Want to uninstall?
1. `Ctrl+Shift+X` → Find Vim → Uninstall
2. Remove vim settings from `settings.json`
3. Delete `keybindings.json` content

---

## Resources

- [VSCodeVim GitHub](https://github.com/VSCodeVim/Vim)
- [VSCodeVim Documentation](https://github.com/VSCodeVim/Vim#-vscodevim)
- Your Nvim Config: `C:\Users\pkhyo\nvim-config-class-bkk-2026\`
- Your Cheatsheet: `VSCODE_VIM_CHEATSHEET.md`

---

**Setup completed successfully!**
