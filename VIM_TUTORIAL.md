# Vim Tutorial - From Zero to Hero

Complete guide to mastering Vim motions, commands, and workflows.

---

## Understanding Vim Modes

Vim has different modes for different tasks:

```
+------------+     i, a, o     +------------+
|            | --------------> |            |
|   NORMAL   |                 |   INSERT   |
|            | <-------------- |            |
+------------+      <Esc>      +------------+
      |
      | v, V, <C-v>
      v
+------------+
|   VISUAL   |
+------------+
```

| Mode | Purpose | How to Enter |
|------|---------|--------------|
| **Normal** | Navigation, commands | `<Esc>` from any mode |
| **Insert** | Typing text | `i`, `a`, `o` from Normal |
| **Visual** | Select text | `v`, `V`, `<C-v>` from Normal |
| **Command** | Run commands | `:` from Normal |

## Basic Navigation (Normal Mode)

### Character Movement
```
      k
      ^
  h <   > l
      v
      j
```

| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |

### Word Movement

| Key | Action |
|-----|--------|
| `w` | Next word (start) |
| `e` | Next word (end) |
| `b` | Previous word |
| `W` | Next WORD (ignore punctuation) |
| `B` | Previous WORD |

### Line Movement

| Key | Action |
|-----|--------|
| `0` | Start of line |
| `^` | First non-blank character |
| `$` | End of line |
| `f{char}` | Find character forward |
| `F{char}` | Find character backward |
| `t{char}` | Till character forward |
| `T{char}` | Till character backward |

### Screen Movement

| Key | Action |
|-----|--------|
| `gg` | Go to first line |
| `G` | Go to last line |
| `{n}G` | Go to line n |
| `<C-d>` | Half page down |
| `<C-u>` | Half page up |
| `<C-f>` | Full page down |
| `<C-b>` | Full page up |
| `H` | Top of screen |
| `M` | Middle of screen |
| `L` | Bottom of screen |
| `zz` | Center cursor on screen |

## Entering Insert Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `I` | Insert at start of line |
| `a` | Append after cursor |
| `A` | Append at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `s` | Substitute character |
| `S` | Substitute entire line |

## Editing (Normal Mode)

### Delete

| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `dw` | Delete word |
| `d$` or `D` | Delete to end of line |
| `d0` | Delete to start of line |
| `diw` | Delete inner word |
| `daw` | Delete a word (with space) |
| `di"` | Delete inside quotes |
| `di(` | Delete inside parentheses |
| `dit` | Delete inside HTML tag |

### Change (Delete + Insert)

| Key | Action |
|-----|--------|
| `cc` | Change entire line |
| `cw` | Change word |
| `c$` or `C` | Change to end of line |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |

### Copy (Yank) & Paste

| Key | Action |
|-----|--------|
| `yy` | Yank (copy) line |
| `yw` | Yank word |
| `y$` | Yank to end of line |
| `yiw` | Yank inner word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Undo & Redo

| Key | Action |
|-----|--------|
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last command |

## Visual Mode (Selection)

| Key | Action |
|-----|--------|
| `v` | Character-wise visual |
| `V` | Line-wise visual |
| `<C-v>` | Block visual (columns) |

After selecting:
- `d` - Delete selection
- `y` - Yank selection
- `c` - Change selection
- `>` - Indent right
- `<` - Indent left
- `~` - Toggle case

## Search & Replace

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |
| `#` | Search word under cursor (backward) |

### Replace

```vim
:s/old/new/      " Replace first on current line
:s/old/new/g     " Replace all on current line
:%s/old/new/g    " Replace all in file
:%s/old/new/gc   " Replace all with confirmation
```

## Working with Files

| Command | Action |
|---------|--------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |
| `:e filename` | Open file |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close buffer |

## Windows & Splits

| Key | Action |
|-----|--------|
| `:sp` | Horizontal split |
| `:vsp` | Vertical split |
| `<C-w>h` | Move to left window |
| `<C-w>j` | Move to below window |
| `<C-w>k` | Move to above window |
| `<C-w>l` | Move to right window |
| `<C-w>w` | Cycle windows |
| `<C-w>q` | Close window |
| `<C-w>=` | Equal window sizes |

## Useful Combinations

### Common Workflows

```
ciw     → Change the word under cursor
ci"     → Change text inside quotes
di(     → Delete inside parentheses
yap     → Yank a paragraph
=G      → Auto-indent to end of file
gg=G    → Auto-indent entire file
gUiw    → Uppercase word
guiw    → Lowercase word
```

### Power Moves

| Command | Action |
|---------|--------|
| `xp` | Swap two characters |
| `ddp` | Swap two lines |
| `yyp` | Duplicate line |
| `ea` | Append at end of word |
| `bi` | Insert at start of word |
| `dap` | Delete a paragraph |
| `>>` | Indent line |
| `<<` | Unindent line |

## The Vim Language

Vim commands follow a pattern:

```
[count] [operator] [motion/text-object]
```

**Operators:**
- `d` = delete
- `c` = change
- `y` = yank
- `>` = indent
- `<` = unindent
- `=` = auto-indent

**Motions:**
- `w` = word
- `b` = back
- `$` = end of line
- `0` = start of line
- `gg` = start of file
- `G` = end of file

**Text Objects:**
- `iw` = inner word
- `aw` = a word (with space)
- `i"` = inner quotes
- `a"` = a quoted string
- `ip` = inner paragraph
- `it` = inner tag

### Examples

| Command | Translation |
|---------|-------------|
| `d2w` | Delete 2 words |
| `c3j` | Change 3 lines down |
| `y$` | Yank to end of line |
| `>ip` | Indent inner paragraph |
| `gUaw` | Uppercase a word |
| `5dd` | Delete 5 lines |
| `2yy` | Yank 2 lines |

## Practice Exercises

### Exercise 1: Basic Navigation
1. Open a file
2. Move to line 10 with `10G`
3. Go to end of file with `G`
4. Go to start with `gg`
5. Move by words with `w` and `b`

### Exercise 2: Editing
1. Delete a word with `dw`
2. Change a word with `cw`
3. Delete a line with `dd`
4. Undo with `u`
5. Redo with `<C-r>`

### Exercise 3: Visual Mode
1. Select a line with `V`
2. Select a word with `viw`
3. Select inside quotes with `vi"`
4. Delete selection with `d`

### Exercise 4: Search & Replace
1. Search for a word with `/word`
2. Go to next match with `n`
3. Replace all with `:%s/old/new/g`

## Tips for Learning

1. **Start slow** - Learn `hjkl`, `i`, `<Esc>`, `:wq` first
2. **Disable arrow keys** - Force yourself to use `hjkl`
3. **Learn one new command per day**
4. **Use `vimtutor`** - Run `vimtutor` in terminal for interactive tutorial
5. **Practice with vim-be-good** - You have this plugin installed!

## Quick Reference Card

```
NORMAL MODE
-----------
Navigation:  h j k l w b e 0 $ gg G
Editing:     d c y p u . x r
Search:      / ? n N * #

INSERT MODE
-----------
Enter:  i a o I A O s S
Exit:   <Esc>

VISUAL MODE
-----------
Enter:  v V <C-v>
Action: d y c > <

COMMAND MODE
------------
:w   :q   :wq   :q!
:s/old/new/g
:%s/old/new/gc
```

---

**Remember:** The best way to learn Vim is to use it every day. Start with basic commands and gradually add more to your workflow. Happy Vimming!
