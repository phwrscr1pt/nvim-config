# Installation Guide

Step-by-step guide to install and configure this Neovim setup on your system.

---

## Requirements

- Neovim 0.10+
- Git
- Node.js (for some LSP servers)
- ripgrep (for Telescope live grep)
- fd (for Telescope file finder)
- Nerd Font (for icons)

## Quick Install (Kali Linux / Debian / Ubuntu)

### Step 1: Install Dependencies

```bash
sudo apt update
sudo apt install neovim git ripgrep fd-find nodejs npm curl unzip
```

### Step 2: Backup Existing Config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

### Step 3: Clone This Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git ~/.config/nvim
```

### Step 4: Install Plugins

Open Neovim:
```bash
nvim
```

Wait for Packer to auto-install, then run:
```vim
:PackerSync
```

Close and reopen Neovim:
```bash
nvim
```

### Step 5: Install Nerd Font (for icons)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

Then set your terminal font to **"JetBrainsMono Nerd Font"**.

## LSP Servers

LSP servers are auto-installed via Mason:

| Language | Server |
|----------|--------|
| Python | pyright |
| Bash | bashls |
| Go | gopls |
| C/C++ | clangd |
| Lua | lua_ls |

To install additional servers:
```vim
:Mason
```

## Verify Installation

Run this checklist in Neovim:

| Check | Command |
|-------|---------|
| Plugins loaded | `:PackerStatus` |
| LSP working | `:LspInfo` |
| Mason servers | `:Mason` |
| Telescope | `<C-p>` |
| File tree | `<Space>e` |
| Terminal | `<Alt-q>` |

## Troubleshooting

### Plugins not installing
```vim
:PackerSync
```

### LSP not working
```vim
:LspInfo
:Mason
```
Install missing servers from Mason UI.

### Icons not showing
- Make sure you installed a Nerd Font
- Set your terminal font to the Nerd Font
- Restart terminal

### Telescope grep not working
```bash
# Check if ripgrep is installed
rg --version

# If not, install it
sudo apt install ripgrep
```

### Colors look wrong
```bash
# Make sure your terminal supports true colors
echo $TERM
# Should be xterm-256color or similar
```

Add to your `~/.bashrc` or `~/.zshrc`:
```bash
export TERM=xterm-256color
```

## Updating

Pull latest changes:
```bash
cd ~/.config/nvim
git pull
```

Update plugins:
```vim
:PackerSync
```

Update LSP servers:
```vim
:Mason
```
Press `U` to update all.

## Uninstall

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
```

## File Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua      # Vim settings
│   │   └── keymaps.lua      # General keybindings
│   └── plugins/
│       ├── init.lua         # Plugin list (Packer)
│       ├── lsp.lua          # LSP configuration
│       ├── telescope.lua    # Fuzzy finder
│       ├── nvim-tree.lua    # File explorer
│       ├── harpoon.lua      # Quick file navigation
│       ├── lualine.lua      # Status line
│       └── toggleterm.lua   # Terminal
├── plugin/
│   └── packer_compiled.lua  # Auto-generated
├── INSTALL.md               # This file
├── KEYBINDINGS.md           # Shortcut reference
└── VIM_TUTORIAL.md          # Vim basics guide
```

## Documentation

### Suggested Learning Order

Follow this path to learn effectively:

| Step | File | What You'll Learn | Time |
|------|------|-------------------|------|
| 1 | **INSTALL.md** (this file) | Setup and configuration | 15 min |
| 2 | [VIM_TUTORIAL.md](VIM_TUTORIAL.md) | Core Vim motions and commands | 1-2 hours |
| 3 | [KEYBINDINGS.md](KEYBINDINGS.md) | This config's shortcuts (keep open while practicing) | Reference |
| 4 | [PLUGINS.md](PLUGINS.md) | File navigation, LSP, Git integration | 30 min |
| 5 | [TMUX_TUTORIAL.md](TMUX_TUTORIAL.md) | Terminal multiplexing | 30 min |
| 6 | [VI_MODE_MANUAL.md](VI_MODE_MANUAL.md) | Vi mode in shell and other tools | 15 min |

### Quick Links

- [KEYBINDINGS.md](KEYBINDINGS.md) - All keyboard shortcuts
- [VIM_TUTORIAL.md](VIM_TUTORIAL.md) - Learn Vim basics
- [PLUGINS.md](PLUGINS.md) - Plugin guide and workflows
- [TMUX_TUTORIAL.md](TMUX_TUTORIAL.md) - Terminal multiplexer
- [VI_MODE_MANUAL.md](VI_MODE_MANUAL.md) - Vi mode everywhere

## One-Line Install (Advanced)

```bash
sudo apt update && sudo apt install -y neovim git ripgrep fd-find nodejs npm curl unzip && git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git ~/.config/nvim && nvim +PackerSync
```

---

Happy coding!
