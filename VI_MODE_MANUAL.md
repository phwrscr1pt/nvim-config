# Vi Mode Manual for Terminal

This guide covers enabling vi keybindings in your shell and readline-based programs.

---

## 1. Vi Mode in Shell

### For Bash

Add to `~/.bashrc`:

```bash
echo "set -o vi" >> ~/.bashrc
```

Reload:

```bash
source ~/.bashrc
```

### For Zsh (Kali Linux default)

Add to `~/.zshrc`:

```bash
echo "bindkey -v" >> ~/.zshrc
```

Reload:

```bash
source ~/.zshrc
```

### Verify Your Shell

```bash
echo $SHELL
```

| Shell | Config File | Vi Mode Command |
|-------|-------------|-----------------|
| Bash  | `~/.bashrc` | `set -o vi` |
| Zsh   | `~/.zshrc`  | `bindkey -v` |

---

## 2. Vi Mode for GNU Readline

Enables vi keybindings in programs that use readline (Python REPL, MySQL, Node.js, etc.)

### Basic Setup

Add to `~/.inputrc`:

```bash
echo "set editing-mode vi" >> ~/.inputrc
```

### Advanced Setup (with cursor indicator)

```bash
cat >> ~/.inputrc << 'EOF'
set editing-mode vi
set show-mode-in-prompt on
set vi-ins-mode-string \1\e[6 q\2
set vi-cmd-mode-string \1\e[2 q\2
EOF
```

### Apply Changes

Restart terminal or press `Ctrl+X Ctrl+R` to reload.

### Programs Using Readline

- Python REPL
- MySQL / MariaDB CLI
- PostgreSQL (psql)
- SQLite
- Node.js REPL
- irb (Ruby)
- GDB
- bc (calculator)

---

## 3. Basic Vi Keybindings Reference

### Modes

| Key | Action |
|-----|--------|
| `Esc` | Enter normal mode |
| `i` | Enter insert mode |
| `a` | Insert after cursor |
| `A` | Insert at end of line |
| `I` | Insert at beginning of line |

### Navigation (Normal Mode)

| Key | Action |
|-----|--------|
| `h` | Move left |
| `l` | Move right |
| `w` | Jump forward one word |
| `b` | Jump backward one word |
| `0` | Go to beginning of line |
| `$` | Go to end of line |
| `j` | Previous command (history) |
| `k` | Next command (history) |

### Editing (Normal Mode)

| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dw` | Delete word |
| `dd` | Delete entire line |
| `D` | Delete to end of line |
| `cw` | Change word |
| `cc` | Change entire line |
| `C` | Change to end of line |
| `r` | Replace single character |
| `u` | Undo |

### Copy/Paste

| Key | Action |
|-----|--------|
| `yy` | Yank (copy) line |
| `yw` | Yank word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Search History

| Key | Action |
|-----|--------|
| `/` | Search backward in history |
| `?` | Search forward in history |
| `n` | Next search result |
| `N` | Previous search result |

---

## 4. Disable Vi Mode

### Bash

```bash
set -o emacs
```

Or remove `set -o vi` from `~/.bashrc`

### Zsh

```bash
bindkey -e
```

Or remove `bindkey -v` from `~/.zshrc`

### Readline

Remove `set editing-mode vi` from `~/.inputrc`

---

## 5. Quick Setup Commands

### One-liner for Zsh + Readline (Kali Linux)

```bash
echo "bindkey -v" >> ~/.zshrc && echo "set editing-mode vi" >> ~/.inputrc && source ~/.zshrc
```

### One-liner for Bash + Readline

```bash
echo "set -o vi" >> ~/.bashrc && echo "set editing-mode vi" >> ~/.inputrc && source ~/.bashrc
```

---

## 6. Terminal Scrolling

### Default Terminal (No tmux)

| Key | Action |
|-----|--------|
| `Shift+PgUp` | Scroll up |
| `Shift+PgDn` | Scroll down |
| `Shift+Home` | Scroll to top |
| `Shift+End` | Scroll to bottom |
| Mouse scroll | If enabled |

### Tmux Scrolling (Copy Mode)

Enter copy mode first: `Ctrl+b [`

| Key | Action |
|-----|--------|
| `j` / `k` | Scroll line by line |
| `Ctrl+d` / `Ctrl+u` | Half page down/up |
| `Ctrl+f` / `Ctrl+b` | Full page down/up |
| `g` | Go to top |
| `G` | Go to bottom |
| `/` | Search forward |
| `?` | Search backward |
| `q` | Exit copy mode |

---

## 7. Tmux Essential Commands

### Session Management

| Command | Action |
|---------|--------|
| `tmux` | Start new session |
| `tmux new -s name` | New session with name |
| `tmux ls` | List sessions |
| `tmux a` | Attach to last session |
| `tmux a -t name` | Attach to named session |
| `Ctrl+b d` | Detach from session |
| `Ctrl+b $` | Rename session |

### Window Management

| Key | Action |
|-----|--------|
| `Ctrl+b c` | Create new window |
| `Ctrl+b n` | Next window |
| `Ctrl+b p` | Previous window |
| `Ctrl+b 0-9` | Go to window number |
| `Ctrl+b ,` | Rename window |
| `Ctrl+b &` | Close window |
| `Ctrl+b w` | List windows |

### Pane Management (Split Screen)

| Key | Action |
|-----|--------|
| `Ctrl+b %` | Split vertical |
| `Ctrl+b "` | Split horizontal |
| `Ctrl+b arrow` | Move between panes |
| `Ctrl+b x` | Close pane |
| `Ctrl+b z` | Zoom pane (fullscreen toggle) |
| `Ctrl+b {` | Swap pane left |
| `Ctrl+b }` | Swap pane right |
| `Ctrl+b space` | Toggle pane layouts |

### Resize Panes

| Key | Action |
|-----|--------|
| `Ctrl+b Ctrl+arrow` | Resize pane |
| `Ctrl+b Alt+arrow` | Resize pane (larger steps) |

---

## 8. Enable Vi Mode in Tmux

Add to `~/.tmux.conf`:

```bash
echo "setw -g mode-keys vi" >> ~/.tmux.conf
```

Reload tmux config:

```bash
tmux source-file ~/.tmux.conf
```

Now copy mode uses vi keybindings.
