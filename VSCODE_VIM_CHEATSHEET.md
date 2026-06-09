# VS Code Vim Cheatsheet

Quick reference for Vim keybindings in VS Code (VSCodeVim extension).

---

> **Leader key:** `Space`

## Your Custom Keybindings

### File Operations

| Keybinding | Action |
|------------|--------|
| `Ctrl+S` | Save file |
| `Alt+S` | Save file |
| `Space ?` | Show all keyboard shortcuts |

### Navigation

| Keybinding | Action |
|------------|--------|
| `Space e` | Toggle file explorer |
| `Ctrl+P` | Quick open (find files) |
| `Space f` | Quick open (find files) |
| `Space ps` | Search in all files |
| `Space gg` | Open Git panel |

### Editor Tabs

| Keybinding | Action |
|------------|--------|
| `Space h` | Show all open editors |
| `Space a` | Pin current editor |
| `Tab` | Next tab |
| `Shift+Tab` | Previous tab |
| `Alt+1` | Go to tab 1 |
| `Alt+2` | Go to tab 2 |
| `Alt+3` | Go to tab 3 |
| `Alt+4` | Go to tab 4 |

### Terminal

| Keybinding | Action |
|------------|--------|
| `Alt+Q` | Toggle terminal |
| `Alt+W` | Toggle terminal |

### Visual Mode

| Keybinding | Action |
|------------|--------|
| `J` | Move selected lines down |
| `K` | Move selected lines up |

---

## Essential Vim Motions

### Modes

| Key | Action |
|-----|--------|
| `Esc` | Normal mode |
| `i` | Insert mode (before cursor) |
| `a` | Insert mode (after cursor) |
| `I` | Insert at line start |
| `A` | Insert at line end |
| `v` | Visual mode (select) |
| `V` | Visual line mode |
| `Ctrl+V` | Visual block mode |

### Movement

| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Start of line |
| `$` | End of line |
| `^` | First non-blank character |
| `gg` | Go to first line |
| `G` | Go to last line |
| `{` | Previous paragraph |
| `}` | Next paragraph |
| `%` | Jump to matching bracket |
| `Ctrl+D` | Page down (half) |
| `Ctrl+U` | Page up (half) |

### Editing

| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `yy` | Yank (copy) line |
| `Y` | Yank to end of line |
| `p` | Paste after |
| `P` | Paste before |
| `u` | Undo |
| `Ctrl+R` | Redo |
| `.` | Repeat last command |
| `>>` | Indent line |
| `<<` | Unindent line |
| `~` | Toggle case |

### Text Objects (use with d, c, y, v)

| Command | Action |
|---------|--------|
| `diw` | Delete inner word |
| `ciw` | Change inner word |
| `daw` | Delete a word (with space) |
| `di"` | Delete inside quotes |
| `ci"` | Change inside quotes |
| `da"` | Delete including quotes |
| `di(` | Delete inside parentheses |
| `ci{` | Change inside braces |
| `dit` | Delete inside HTML tag |
| `cit` | Change inside HTML tag |

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |
| `#` | Search word backward |

### Replace

| Command | Action |
|---------|--------|
| `r` | Replace single character |
| `R` | Replace mode |
| `:s/old/new` | Replace first in line |
| `:s/old/new/g` | Replace all in line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirm |

---

## VS Code Specific Commands

### LSP / Code Intelligence

| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Show hover (documentation) |
| `Ctrl+Space` | Trigger autocomplete |
| `F2` | Rename symbol |
| `F12` | Go to definition |
| `Shift+F12` | Show references |

### Window Management

| Keybinding | Action |
|------------|--------|
| `Ctrl+\` | Split editor |
| `Ctrl+1/2/3` | Focus editor group |
| `Ctrl+W` then `h/j/k/l` | Navigate splits |

### Useful Ex Commands

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `:e filename` | Open file |
| `:vs filename` | Vertical split |
| `:sp filename` | Horizontal split |
| `:tabnew` | New tab |
| `:tabnext` | Next tab |
| `:tabprev` | Previous tab |

---

## EasyMotion (Space Space)

| Keybinding | Action |
|------------|--------|
| `Space Space w` | Jump to word |
| `Space Space b` | Jump to word backward |
| `Space Space j` | Jump to line below |
| `Space Space k` | Jump to line above |
| `Space Space f{char}` | Jump to character |

---

## Surround (vim-surround)

| Command | Action |
|---------|--------|
| `ys{motion}{char}` | Add surround |
| `ysiw"` | Surround word with quotes |
| `cs{old}{new}` | Change surround |
| `cs"'` | Change " to ' |
| `ds{char}` | Delete surround |
| `ds"` | Delete quotes |
| `S{char}` (visual) | Surround selection |

---

## Quick Reference Card

```
MOVEMENT          EDIT              VISUAL
h j k l           i a I A           v V Ctrl+V
w b e             d c y p
0 $ ^             dd yy             TEXT OBJECTS
gg G              u Ctrl+R          iw aw
{ }               . >> <<           i" a" i( a(

SEARCH            CUSTOM (Space+)   TERMINAL
/ ? n N           e = explorer      Alt+Q toggle
* #               f = find files    Alt+W toggle
                  ps = search
                  gg = git
                  ? = help
```

---

## Legend

| Symbol | Key |
|--------|-----|
| `Ctrl+X` | Ctrl + X |
| `Alt+X` | Alt + X |
| `Shift+X` | Shift + X |
| `Space` | Spacebar (Leader) |

---

## Tips

1. **Practice motions first**: `hjkl`, `w`, `b`, `e`, `0`, `$`
2. **Learn text objects**: `ciw`, `di"`, `da(` are powerful
3. **Use `.` to repeat**: Make a change, then `.` repeats it
4. **Combine motions**: `d2w` deletes 2 words, `3j` moves 3 lines down
5. **Use `/` to search**: Faster than scrolling

---

Happy coding!
