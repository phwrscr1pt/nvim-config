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

## Fix: Alt Keybindings Not Working (2026-06-09)

### Problem

Some keybindings were not working on Windows:
- `Alt+Q`, `Alt+W`, `Alt+S` - Did not trigger
- `Space k` - Error: "The editor could not be opened"

### Root Cause

1. **Alt keybindings** - VSCodeVim on Windows doesn't handle Alt key combinations reliably
2. **Space k** - The `vscode.open` command requires URI format (`file:///C:/...`), not Windows path format

### Solution

Moved problematic keybindings from `settings.json` (Vim) to `keybindings.json` (VS Code native).

**Updated settings.json** - Removed broken Alt keybindings:
```json
"vim.normalModeKeyBindingsNonRecursive": [
    { "before": ["<leader>", "?"], "commands": ["workbench.action.openGlobalKeybindings"] },
    { "before": ["<C-s>"], "commands": [":w"] },
    { "before": ["<leader>", "e"], "commands": ["workbench.view.explorer"] },
    { "before": ["<C-p>"], "commands": ["workbench.action.quickOpen"] },
    { "before": ["<leader>", "f"], "commands": ["workbench.action.quickOpen"] },
    { "before": ["<leader>", "p", "s"], "commands": ["workbench.action.findInFiles"] },
    { "before": ["<leader>", "g", "g"], "commands": ["workbench.view.scm"] },
    { "before": ["<leader>", "h"], "commands": ["workbench.action.showAllEditors"] },
    { "before": ["<leader>", "a"], "commands": ["workbench.action.pinEditor"] },
    { "before": ["<A-1>"], "commands": ["workbench.action.openEditorAtIndex1"] },
    { "before": ["<A-2>"], "commands": ["workbench.action.openEditorAtIndex2"] },
    { "before": ["<A-3>"], "commands": ["workbench.action.openEditorAtIndex3"] },
    { "before": ["<A-4>"], "commands": ["workbench.action.openEditorAtIndex4"] },
    { "before": ["<tab>"], "commands": [":tabnext"] },
    { "before": ["<S-tab>"], "commands": [":tabprev"] }
]
```

**Updated keybindings.json** - Added working keybindings:
```json
[
    {
        "key": "ctrl+shift+k",
        "command": "vscode.open",
        "args": "file:///C:/Users/pkhyo/nvim-config-class-bkk-2026/VSCODE_VIM_CHEATSHEET.md"
    },
    {
        "key": "alt+s",
        "command": "workbench.action.files.save",
        "when": "editorTextFocus"
    },
    {
        "key": "alt+q",
        "command": "workbench.action.terminal.toggleTerminal"
    },
    {
        "key": "alt+w",
        "command": "workbench.action.terminal.toggleTerminal"
    },
    {
        "key": "space k",
        "command": "vscode.open",
        "args": "file:///C:/Users/pkhyo/nvim-config-class-bkk-2026/VSCODE_VIM_CHEATSHEET.md",
        "when": "editorTextFocus && vim.mode == 'Normal'"
    }
]
```

### Lesson Learned

> **On Windows, Alt keybindings work better in VS Code's `keybindings.json` than in VSCodeVim's settings.**

For file paths with `vscode.open`, always use URI format: `file:///C:/path/to/file`

---

## Fix: Space Keybindings Broken (2026-06-09)

### Problem

After adding `space k` to `keybindings.json`, ALL Space leader keybindings stopped working (`Space e`, `Space f`, etc.)

### Root Cause

VS Code's `keybindings.json` was intercepting the Space key before VSCodeVim could use it as the leader key.

### Solution

1. **Removed** `space k` from `keybindings.json`
2. **Added** `Space k` back to vim settings using `:e` command:
```json
{ "before": ["<leader>", "k"], "commands": [":e C:\\Users\\pkhyo\\nvim-config-class-bkk-2026\\VSCODE_VIM_CHEATSHEET.md"] }
```

### Lesson Learned

> **Never use `space` as a key in VS Code's `keybindings.json` when using VSCodeVim - it will intercept the leader key.**

---

## Enhancement: Navigation Keybindings (2026-06-09)

### Problem

- No easy way to close tabs without typing `:q`
- Difficult to return from search panel to editor
- Need to use mouse to navigate search results

### Solution

**Added to settings.json (vim keybindings):**
```json
{ "before": ["<leader>", "q"], "commands": [":q"] },
{ "before": ["<leader>", "x"], "commands": [":bd"] },
{ "before": ["<leader>", "1"], "commands": ["workbench.action.focusFirstEditorGroup"] }
```

**Added to keybindings.json (Escape handling):**
```json
{
    "key": "escape",
    "command": "workbench.action.focusActiveEditorGroup",
    "when": "searchViewletFocus"
},
{
    "key": "escape",
    "command": "workbench.action.focusActiveEditorGroup",
    "when": "sideBarFocus"
}
```

### New Keybindings Added

| Keybinding | Action |
|------------|--------|
| `Space q` | Close current tab |
| `Space x` | Close buffer/tab |
| `Space 1` | Focus editor |
| `Escape` (in search/sidebar) | Return to editor |

### Search Results Navigation

| Keybinding | Action |
|------------|--------|
| `↓` / `↑` | Navigate results in search panel |
| `Enter` | Open selected result |
| `F4` | Next search result |
| `Shift+F4` | Previous search result |

---

## Current Configuration (2026-06-09)

### settings.json (Vim Keybindings)
```json
"vim.normalModeKeyBindingsNonRecursive": [
    { "before": ["<leader>", "?"], "commands": ["workbench.action.openGlobalKeybindings"] },
    { "before": ["<leader>", "k"], "commands": [":e C:\\Users\\pkhyo\\nvim-config-class-bkk-2026\\VSCODE_VIM_CHEATSHEET.md"] },
    { "before": ["<C-s>"], "commands": [":w"] },
    { "before": ["<leader>", "e"], "commands": ["workbench.view.explorer"] },
    { "before": ["<C-p>"], "commands": ["workbench.action.quickOpen"] },
    { "before": ["<leader>", "f"], "commands": ["workbench.action.quickOpen"] },
    { "before": ["<leader>", "p", "s"], "commands": ["workbench.action.findInFiles"] },
    { "before": ["<leader>", "g", "g"], "commands": ["workbench.view.scm"] },
    { "before": ["<leader>", "h"], "commands": ["workbench.action.showAllEditors"] },
    { "before": ["<leader>", "a"], "commands": ["workbench.action.pinEditor"] },
    { "before": ["<leader>", "q"], "commands": [":q"] },
    { "before": ["<leader>", "x"], "commands": [":bd"] },
    { "before": ["<leader>", "1"], "commands": ["workbench.action.focusFirstEditorGroup"] },
    { "before": ["<A-1>"], "commands": ["workbench.action.openEditorAtIndex1"] },
    { "before": ["<A-2>"], "commands": ["workbench.action.openEditorAtIndex2"] },
    { "before": ["<A-3>"], "commands": ["workbench.action.openEditorAtIndex3"] },
    { "before": ["<A-4>"], "commands": ["workbench.action.openEditorAtIndex4"] },
    { "before": ["<tab>"], "commands": [":tabnext"] },
    { "before": ["<S-tab>"], "commands": [":tabprev"] }
]
```

### keybindings.json
```json
[
    {
        "key": "ctrl+shift+k",
        "command": "vscode.open",
        "args": "file:///C:/Users/pkhyo/nvim-config-class-bkk-2026/VSCODE_VIM_CHEATSHEET.md"
    },
    {
        "key": "alt+s",
        "command": "workbench.action.files.save",
        "when": "editorTextFocus"
    },
    {
        "key": "alt+q",
        "command": "workbench.action.terminal.toggleTerminal"
    },
    {
        "key": "alt+w",
        "command": "workbench.action.terminal.toggleTerminal"
    },
    {
        "key": "escape",
        "command": "workbench.action.focusActiveEditorGroup",
        "when": "searchViewletFocus"
    },
    {
        "key": "escape",
        "command": "workbench.action.focusActiveEditorGroup",
        "when": "sideBarFocus"
    }
]
```

---

**Setup completed successfully!**
