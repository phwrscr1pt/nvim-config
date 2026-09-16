# Vim Text Objects Guide

A complete guide to Vim text objects - one of Vim's most powerful features.

---

## What Are Text Objects?

Text objects let you operate on **chunks of text** based on structure, not just cursor position. Instead of moving to the start and end of what you want to change, you simply describe "what" you want to change.

---

## The Pattern

```
[operator] + [i/a] + [object]
```

| Part | Meaning |
|------|---------|
| Operator | `d` (delete), `c` (change), `y` (yank), `v` (select) |
| `i` | **inner** - inside only, excludes boundaries |
| `a` | **a/around** - includes boundaries |
| Object | `w` (word), `"` (quotes), `(` (parentheses), etc. |

---

## All Text Object Boundaries

### Word Boundaries

| Object | Description | Example |
|--------|-------------|---------|
| `w` | word (stops at punctuation) | `hello` in `hello-world` |
| `W` | WORD (whitespace-separated) | `hello-world` as one unit |

### Quote Boundaries

| Object | Description | Example |
|--------|-------------|---------|
| `"` | double quotes | `"hello"` |
| `'` | single quotes | `'hello'` |
| `` ` `` | backticks | `` `hello` `` |

### Bracket Boundaries

| Object | Description | Example |
|--------|-------------|---------|
| `(` or `)` or `b` | parentheses | `(hello)` |
| `[` or `]` | square brackets | `[hello]` |
| `{` or `}` or `B` | curly braces | `{hello}` |
| `<` or `>` | angle brackets | `<hello>` |

### Block Boundaries

| Object | Description |
|--------|-------------|
| `t` | HTML/XML tag (e.g. `<div>content</div>`) |
| `s` | sentence (ends with `.` `!` `?`) |
| `p` | paragraph (blank line separated) |

---

## The `i` vs `a` Difference

| Prefix | Meaning | Example with `"hello"` |
|--------|---------|------------------------|
| `i` | **inner** (excludes boundary) | selects `hello` |
| `a` | **around** (includes boundary) | selects `"hello"` |

### Visual Example

Given this code with cursor on `hello`:
```python
print("hello world")
```

| Command | What it selects | Result after `d` |
|---------|-----------------|------------------|
| `diw` | `hello` | `print(" world")` |
| `daw` | `hello ` (with space) | `print("world")` |
| `di"` | `hello world` | `print("")` |
| `da"` | `"hello world"` | `print()` |
| `di(` | `"hello world"` | `print()` |
| `da(` | `("hello world")` | `print` |

---

## Using Counts with Text Objects

Add a number before the text object to repeat or expand:

```
[operator] + [count] + [i/a] + [object]
```

### Counts with Words

```python
one two three four five
#^cursor here
```

| Command | What it deletes |
|---------|-----------------|
| `daw` | `one ` |
| `d2aw` | `one two ` |
| `d3aw` | `one two three ` |
| `d5aw` | `one two three four five ` |

### Counts with Nested Brackets

```python
data = { "outer": { "inner": "value" } }
#                    ^cursor here
```

| Command | What it selects/deletes |
|---------|-------------------------|
| `di{` | `"inner": "value"` (innermost) |
| `d2i{` | `"outer": { "inner": "value" }` (one level out) |

### Counts with Nested Quotes

```python
text = "She said 'hello' to me"
#                 ^cursor here
```

| Command | What it changes |
|---------|-----------------|
| `ci'` | `hello` (inner single quotes) |
| `ci"` | `She said 'hello' to me` (outer double quotes) |

### Counts with Nested HTML Tags

```html
<div><span><b>Hello</b></span></div>
#            ^cursor here
```

| Command | What it operates on |
|---------|---------------------|
| `dit` | `Hello` (innermost `<b>`) |
| `d2it` | `<b>Hello</b>` (inside `<span>`) |
| `d3it` | `<span><b>Hello</b></span>` (inside `<div>`) |

---

## Practical Examples

### Example 1: Working with Strings

```python
message = "Hello, World!"
#               ^cursor
```

| Command | Action | Result |
|---------|--------|--------|
| `ci"` | Change inside quotes | `message = ""` (insert mode) |
| `di"` | Delete inside quotes | `message = ""` |
| `yi"` | Yank inside quotes | copies `Hello, World!` |
| `vi"` | Select inside quotes | visually selects content |

### Example 2: Working with Function Arguments

```python
print(format(get_name(user_id)))
#                      ^cursor
```

| Command | Action |
|---------|--------|
| `ci(` | Change `user_id` |
| `c2i(` | Change `get_name(user_id)` |
| `c3i(` | Change `format(get_name(user_id))` |

### Example 3: Working with JSON

```json
{ "level1": { "level2": { "level3": "data" } } }
#                         ^cursor
```

| Command | What it yanks |
|---------|---------------|
| `yi{` | `"level3": "data"` |
| `y2i{` | `"level2": { "level3": "data" }` |
| `y3i{` | `"level1": { "level2": { "level3": "data" } }` |

### Example 4: Working with HTML

```html
<div class="container">
    <p>This is a paragraph.</p>
</div>
```

| Command | Action |
|---------|--------|
| `dit` | Delete/change content inside current tag |
| `dat` | Delete entire tag including `<tag>` and `</tag>` |
| `cit` | Change content inside tag |
| `yat` | Yank entire tag |

### Example 5: Working with Arrays

```javascript
const items = [1, 2, [3, 4, [5, 6]], 7];
#                          ^cursor
```

| Command | What it operates on |
|---------|---------------------|
| `di[` | `5, 6` |
| `d2i[` | `3, 4, [5, 6]` |
| `d3i[` | `1, 2, [3, 4, [5, 6]], 7` |

---

## Common Operations Cheat Sheet

### Most Used Commands

| Command | Action |
|---------|--------|
| `ciw` | Change word |
| `caw` | Change word + space |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ci{` | Change inside braces |
| `cit` | Change inside tag |
| `diw` | Delete word |
| `daw` | Delete word + space |
| `di"` | Delete inside quotes |
| `da"` | Delete including quotes |
| `yiw` | Yank word |
| `yap` | Yank paragraph |

### Quick Reference

```
QUOTES          BRACKETS         BLOCKS
"  double       ( ) b  parens    t  tag
'  single       [ ]    square    s  sentence
`  backtick     { } B  curly     p  paragraph
                < >    angle     w  word
                                 W  WORD
```

---

## Tips & Tricks

### 1. Use `c` more than `d`
`ci"` puts you in insert mode ready to type. Faster than `di"` + `i`.

### 2. Visual mode to preview
Not sure what will be selected? Use `v` instead of `d`:
- `vi{` shows you what's inside braces before you delete

### 3. Repeat with `.`
After `ciw` + new text + `Esc`, press `.` on another word to repeat the change.

### 4. Combine with search
- `/word` to find
- `ciw` to change
- `n` to next occurrence
- `.` to repeat change

### 5. Remember `a` includes boundaries
- `di"` leaves empty `""`
- `da"` deletes quotes too

---

## Practice Exercises

Try these on sample text:

1. **Change a word**: Put cursor on any word, type `ciw`, type new word, press `Esc`

2. **Delete inside quotes**:
   ```
   name = "John Doe"
   ```
   Put cursor inside quotes, type `di"`

3. **Change function argument**:
   ```
   calculate(100, 200)
   ```
   Put cursor on `100`, type `ci(`, type new values

4. **Yank a paragraph**: Put cursor in a paragraph, type `yap`, then `p` to paste

5. **Delete entire HTML tag**:
   ```
   <span>Delete me</span>
   ```
   Put cursor inside, type `dat`

---

## Summary

| Count | Effect |
|-------|--------|
| `1` (default) | Innermost/closest boundary |
| `2` | One level out |
| `3` | Two levels out |
| `n` | (n-1) levels out |

Text objects are powerful because they:
- Work regardless of cursor position within the object
- Handle nested structures with counts
- Combine with any operator (`d`, `c`, `y`, `v`)
- Make editing faster and more intuitive

---

## Motions (Moving the Cursor)

Text objects select regions for operators, but **motions** move your cursor. Here's the complete reference.

### Word Motions

| Key | Movement |
|-----|----------|
| `w` | Start of **next** word |
| `b` | Start of **previous** word (back) |
| `e` | **End** of current/next word |
| `ge` | End of previous word |
| `W` | Next WORD (whitespace-separated) |
| `B` | Previous WORD |
| `E` | End of WORD |

```
   hello_world  foo  bar
   ^    ^    ^  ^    ^
   w    e    w  w    w    (forward)
   b    b    b  b         (backward)
```

### Find on Current Line

| Key | Movement |
|-----|----------|
| `f{char}` | **Find** next `{char}` |
| `F{char}` | Find previous `{char}` |
| `t{char}` | Jump **to** (before) next `{char}` |
| `T{char}` | Jump to (after) previous `{char}` |
| `;` | Repeat last `f`/`F`/`t`/`T` forward |
| `,` | Repeat last `f`/`F`/`t`/`T` backward |

**Example:**
```
print("hello world")
^
```

| Command | Cursor moves to |
|---------|-----------------|
| `f"` | First `"` |
| `f";` | Second `"` (repeat) |
| `fw` | The `w` in `world` |
| `t)` | Just before `)` |

### Bracket Matching

| Key | Movement |
|-----|----------|
| `%` | Jump to matching bracket `()` `[]` `{}` |

### Line Motions

| Key | Movement |
|-----|----------|
| `0` | Start of line (column 0) |
| `^` | First non-whitespace character |
| `$` | End of line |
| `g_` | Last non-whitespace character |

### File Motions

| Key | Movement |
|-----|----------|
| `gg` | First line of file |
| `G` | Last line of file |
| `5G` or `5gg` | Go to line 5 |
| `50%` | Go to 50% of file |

### Search Motions

| Key | Movement |
|-----|----------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor (forward) |
| `#` | Search word under cursor (backward) |

### Paragraph & Sentence Motions

| Key | Movement |
|-----|----------|
| `{` | Previous paragraph (blank line) |
| `}` | Next paragraph |
| `(` | Previous sentence |
| `)` | Next sentence |

### Vertical Motions

| Key | Movement |
|-----|----------|
| `j` | Down one line |
| `k` | Up one line |
| `5j` | Down 5 lines |
| `10k` | Up 10 lines |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `Ctrl+f` | Full page down |
| `Ctrl+b` | Full page up |
| `H` | Top of screen (High) |
| `M` | Middle of screen |
| `L` | Bottom of screen (Low) |

### Jump History

| Key | Movement |
|-----|----------|
| `Ctrl+o` | Jump to previous location |
| `Ctrl+i` | Jump to next location |

---

> **Note:** This config now installs **flash.nvim** (label jump on `s`/`S`, plus
> enhanced cross-line `f`/`t`) and **nvim-treesitter-textobjects** (`vif`/`vaf`,
> `vic`/`vac`, and `]f`/`[f` in code files). The built-in motions/objects above
> still work everywhere; these plugins add on top.

---

## Motions + Operators

Motions can be combined with operators just like text objects:

| Command | Action |
|---------|--------|
| `dw` | Delete to next word |
| `d$` | Delete to end of line |
| `d/foo` | Delete until "foo" |
| `cf)` | Change until `)` |
| `yt"` | Yank until `"` |
| `d}` | Delete to next paragraph |
| `y5j` | Yank 6 lines (current line + 5 down) |

### Motions vs Text Objects

| Motions | Text Objects |
|---------|--------------|
| `dw` - delete to next word start | `diw` - delete entire word |
| `df"` - delete through `"` | `di"` - delete inside quotes |
| `d}` - delete to paragraph end | `dap` - delete entire paragraph |

**Key difference:** Motions work from cursor position, text objects work on the entire structure regardless of cursor position within it.

---

## Quick Reference Card

```
WORD MOTIONS          LINE MOTIONS         FILE MOTIONS
w   next word         0   line start       gg  file start
b   prev word         ^   first char       G   file end
e   end word          $   line end         5G  line 5
W/B/E  by WORD        g_  last char        %   matching bracket

FIND ON LINE          SEARCH               VERTICAL
f{c}  find char       /pattern  forward    j/k    up/down
t{c}  to char         ?pattern  backward   Ctrl+d half page down
;     repeat          n/N  next/prev       Ctrl+u half page up
,     reverse         */#  word search     H/M/L  screen position
```

---

Happy Vimming!
