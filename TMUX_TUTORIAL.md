# Tmux Tutorial

Tmux (Terminal Multiplexer) - Run multiple terminals in one window, keep sessions alive.

## Why Use Tmux?

- **Split terminal** into multiple panes
- **Keep sessions running** after disconnect (SSH)
- **Switch between** multiple projects
- **Essential for** security work and remote servers

## Installation

```bash
sudo apt install tmux
```

## Basic Concepts

```
┌─────────────────────────────────────────────┐
│ Tmux Server                                 │
│  ├── Session 1 (e.g., "work")              │
│  │    ├── Window 1 (e.g., "code")          │
│  │    │    ├── Pane 1                      │
│  │    │    └── Pane 2                      │
│  │    └── Window 2 (e.g., "server")        │
│  └── Session 2 (e.g., "hack")              │
│       └── Window 1                          │
└─────────────────────────────────────────────┘
```

| Term | Description |
|------|-------------|
| **Session** | Collection of windows (like a workspace) |
| **Window** | A single screen (like a tab) |
| **Pane** | Split section of a window |

## Prefix Key

All tmux commands start with a **prefix key**.

**Default prefix:** `Ctrl + b`

Example: To split window, press `Ctrl+b` then `%`

Written as: `<prefix> %` or `C-b %`

---

## Quick Start

### Start tmux
```bash
tmux
```

### Start with session name
```bash
tmux new -s mysession
```

### Detach from session
```
<prefix> d       (Ctrl+b, then d)
```

### List sessions
```bash
tmux ls
```

### Attach to session
```bash
tmux attach -t mysession
# or
tmux a -t mysession
```

---

## Session Commands

| Command | Action |
|---------|--------|
| `tmux new -s name` | Create new session |
| `tmux ls` | List sessions |
| `tmux a -t name` | Attach to session |
| `tmux kill-session -t name` | Kill session |
| `<prefix> d` | Detach from session |
| `<prefix> $` | Rename session |
| `<prefix> s` | List/switch sessions |
| `<prefix> (` | Previous session |
| `<prefix> )` | Next session |

---

## Window Commands (Tabs)

| Keybinding | Action |
|------------|--------|
| `<prefix> c` | Create new window |
| `<prefix> ,` | Rename current window |
| `<prefix> w` | List windows |
| `<prefix> n` | Next window |
| `<prefix> p` | Previous window |
| `<prefix> 0-9` | Go to window number |
| `<prefix> &` | Kill current window |
| `<prefix> f` | Find window by name |

---

## Pane Commands (Splits)

### Creating Panes

| Keybinding | Action |
|------------|--------|
| `<prefix> %` | Split vertically (left/right) |
| `<prefix> "` | Split horizontally (top/bottom) |

```
Before:           After <prefix> %:      After <prefix> ":
┌─────────┐       ┌────┬────┐           ┌─────────┐
│         │       │    │    │           │         │
│         │  -->  │    │    │     -->   ├─────────┤
│         │       │    │    │           │         │
└─────────┘       └────┴────┘           └─────────┘
```

### Navigating Panes

| Keybinding | Action |
|------------|--------|
| `<prefix> ←↑↓→` | Move to pane (arrow keys) |
| `<prefix> o` | Next pane |
| `<prefix> ;` | Last active pane |
| `<prefix> q` | Show pane numbers |
| `<prefix> q 0-9` | Go to pane number |

### Resizing Panes

| Keybinding | Action |
|------------|--------|
| `<prefix> C-←` | Resize left (Ctrl+arrow) |
| `<prefix> C-→` | Resize right |
| `<prefix> C-↑` | Resize up |
| `<prefix> C-↓` | Resize down |
| `<prefix> z` | Toggle pane zoom (fullscreen) |

### Managing Panes

| Keybinding | Action |
|------------|--------|
| `<prefix> x` | Kill current pane |
| `<prefix> !` | Convert pane to window |
| `<prefix> {` | Move pane left |
| `<prefix> }` | Move pane right |
| `<prefix> Space` | Toggle pane layouts |

---

## Copy Mode (Scrolling)

| Keybinding | Action |
|------------|--------|
| `<prefix> [` | Enter copy mode |
| `q` | Exit copy mode |
| `↑↓←→` | Navigate |
| `Page Up/Down` | Scroll pages |
| `g` | Go to top |
| `G` | Go to bottom |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `Space` | Start selection |
| `Enter` | Copy selection |
| `<prefix> ]` | Paste |

---

## Common Layouts

### 2 Panes Side by Side
```bash
tmux new -s dev
# <prefix> %
```
```
┌────────┬────────┐
│  code  │  term  │
│        │        │
└────────┴────────┘
```

### 3 Panes (IDE Style)
```
┌────────┬────────┐
│        │  top   │
│  main  ├────────┤
│        │ bottom │
└────────┴────────┘
```
Commands:
1. `<prefix> %` (split vertical)
2. Move right: `<prefix> →`
3. `<prefix> "` (split horizontal)

### 4 Panes Grid
```
┌────────┬────────┐
│   1    │   2    │
├────────┼────────┤
│   3    │   4    │
└────────┴────────┘
```
Commands:
1. `<prefix> %`
2. `<prefix> "`
3. `<prefix> ←`
4. `<prefix> "`

---

## Useful Command Mode

Press `<prefix> :` to enter command mode.

| Command | Action |
|---------|--------|
| `:new-window` | Create window |
| `:rename-window name` | Rename window |
| `:split-window` | Split horizontal |
| `:split-window -h` | Split vertical |
| `:resize-pane -D 10` | Resize down 10 |
| `:resize-pane -U 10` | Resize up 10 |
| `:resize-pane -L 10` | Resize left 10 |
| `:resize-pane -R 10` | Resize right 10 |
| `:setw synchronize-panes` | Sync input to all panes |

---

## Configuration (~/.tmux.conf)

Create a config file for customization:

```bash
nvim ~/.tmux.conf
```

### Recommended Config

```bash
# Change prefix to Ctrl+a (easier to reach)
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Enable mouse support
set -g mouse on

# Split panes with | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config with r
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# Switch panes with Alt+arrow (no prefix needed)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Better colors
set -g default-terminal "screen-256color"

# Status bar
set -g status-style bg=black,fg=white
set -g window-status-current-style bg=white,fg=black
```

### Apply Config
```bash
tmux source-file ~/.tmux.conf
# Or inside tmux: <prefix> :source-file ~/.tmux.conf
```

---

## Tmux for Security Work

### Pentest Setup

```bash
# Create pentest session
tmux new -s pentest

# Window 1: Recon
<prefix> , (rename to "recon")

# Window 2: Exploit
<prefix> c
<prefix> , (rename to "exploit")

# Window 3: Post
<prefix> c
<prefix> , (rename to "post")
```

### Multi-Target Setup

```bash
# Sync panes - type once, execute on all
<prefix> :setw synchronize-panes on

# Turn off
<prefix> :setw synchronize-panes off
```

### Keep Session on SSH Disconnect

```bash
# On remote server
tmux new -s hack

# Do your work...
# Connection drops? No problem!

# Reconnect later
ssh user@server
tmux a -t hack
# Everything is still there!
```

---

## Quick Reference Card

```
SESSION
-------
tmux new -s name     Create session
tmux a -t name       Attach session
tmux ls              List sessions
<prefix> d           Detach
<prefix> s           Switch session

WINDOW
------
<prefix> c           New window
<prefix> ,           Rename window
<prefix> n/p         Next/prev window
<prefix> 0-9         Go to window
<prefix> w           List windows

PANE
----
<prefix> %           Split vertical
<prefix> "           Split horizontal
<prefix> ←↑↓→        Navigate panes
<prefix> z           Zoom pane
<prefix> x           Kill pane
<prefix> Space       Change layout

COPY MODE
---------
<prefix> [           Enter copy mode
q                    Exit copy mode
Space                Start selection
Enter                Copy
<prefix> ]           Paste
```

---

## Tmux + Neovim Workflow

```bash
# Start tmux
tmux new -s project

# Split for code and terminal
<prefix> %

# Left pane: Neovim
nvim .

# Right pane: Run commands, tests, etc.
<prefix> →
python script.py

# Switch between with <prefix> ← and <prefix> →
```

---

## Tips

1. **Always name sessions** - `tmux new -s name` instead of just `tmux`
2. **Use mouse mode** - Add `set -g mouse on` to config
3. **Change prefix** - `Ctrl+a` is easier than `Ctrl+b`
4. **Zoom for focus** - `<prefix> z` to fullscreen a pane
5. **Sync panes** - Great for multi-server commands

---

Happy multiplexing!
