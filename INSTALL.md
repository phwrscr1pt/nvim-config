# Installation Guide

Step-by-step guide to install and configure this Neovim setup on your system.

---

## TL;DR - Copy-Paste for Fresh Kali

If you just want to copy-paste everything and get it working:

```bash
# 1. Install all dependencies
sudo apt update && sudo apt install -y neovim git ripgrep fd-find nodejs npm curl unzip build-essential

# 2. Install lazygit
# Get latest version number
LAZYGIT_VERSION="0.44.1"
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# 3. Install Nerd Font
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip && rm JetBrainsMono.zip && fc-cache -fv && cd ~

# 4. Clean old configs (if any)
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim

# 5. Clone this repo
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git ~/.config/nvim

# 6. Install plugins (ignore first-run errors, they are normal!)
nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"

# 7. Run again to finish setup
nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
```

**After running above:** Set your terminal font to "JetBrainsMono Nerd Font Mono", restart terminal, then run `nvim`.

---

## Requirements

- Neovim 0.10+
- Git
- Node.js (for some LSP servers)
- ripgrep (for Telescope live grep)
- fd (for Telescope file finder)
- lazygit (for Git integration)
- Nerd Font (for icons)

---

## Fresh Kali Linux Installation (Complete Guide)

If you have a fresh Kali with nothing installed, follow these steps carefully.

### Step 1: Update System

```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: Install ALL Dependencies

```bash
sudo apt install -y neovim git ripgrep fd-find nodejs npm curl unzip build-essential
```

### Step 3: Install lazygit (for Git integration)

```bash
# Get latest version number
LAZYGIT_VERSION="0.44.1"
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz
```

Verify:
```bash
lazygit --version
```

### Step 4: Install Nerd Font (IMPORTANT - do this BEFORE opening Neovim)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
cd ~
```

Then set your terminal font to **"JetBrainsMono Nerd Font"**:
- **Kali Terminal**: Right-click → Preferences → Custom font → "JetBrainsMono Nerd Font Mono"
- **Qterminal**: Edit → Preferences → Appearance → Font

### Step 5: Backup Existing Config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.backup 2>/dev/null
```

### Step 6: Clone This Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git ~/.config/nvim
```

### Step 7: First Run - Install Plugins (IMPORTANT!)

**This step has multiple parts. Read carefully.**

**7a.** Open Neovim:
```bash
nvim
```

**7b.** You will see errors like this - **THIS IS NORMAL ON FIRST RUN**:
```
Error running config for toggleterm.nvim: module 'toggleterm' not found
```

These errors happen because plugins haven't been downloaded yet. **Ignore them.**

**7c.** Wait 5-10 seconds for Packer to auto-bootstrap, then run:
```vim
:PackerSync
```

**7d.** Wait for all plugins to download (you'll see progress in a split window).

**7e.** When done, **QUIT Neovim completely**:
```vim
:qa
```

**7f.** Open Neovim again:
```bash
nvim
```

**7g.** Run PackerSync ONE MORE TIME to compile everything:
```vim
:PackerSync
```

**7h.** Quit and reopen Neovim:
```bash
nvim
```

Now everything should work without errors!

### Step 8: Verify Installation

Run these commands in Neovim to verify everything works:

| Check | Command | Expected |
|-------|---------|----------|
| Plugins | `:PackerStatus` | All plugins listed |
| LSP | `:LspInfo` | Shows attached servers |
| Mason | `:Mason` | Opens Mason UI |
| File finder | `Ctrl+p` | Opens Telescope |
| File tree | `Space e` | Opens file explorer |
| Terminal | `Alt+q` | Opens floating terminal |
| Git | `Space g g` | Opens lazygit |

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

### "module 'toggleterm' not found" or similar errors on first run

**This is NORMAL on first run!** The error happens because:
1. Neovim tries to load plugin configs
2. But plugins haven't been downloaded yet

**Solution:**
```bash
# 1. Ignore the errors and run:
:PackerSync

# 2. QUIT Neovim completely:
:qa

# 3. Open again and run PackerSync again:
nvim
:PackerSync

# 4. Quit and reopen:
:qa
nvim
```

If errors persist after this, delete everything and start fresh:
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
nvim
:PackerSync
:qa
nvim
```

### Plugins not installing
```vim
:PackerSync
```

If that doesn't work, check your internet connection and try:
```vim
:PackerClean
:PackerInstall
:PackerCompile
```

### LSP not working
```vim
:LspInfo
:Mason
```
Install missing servers from Mason UI. Press `i` to install.

### Mason servers fail to install

Some servers need additional tools:
```bash
# For most servers
sudo apt install -y build-essential

# For Python (pyright)
sudo apt install -y python3 python3-pip

# For C/C++ (clangd)
sudo apt install -y clang

# For Go (gopls)
sudo apt install -y golang
```

### lazygit not working (`<Space>gg` does nothing)

Make sure lazygit is installed:
```bash
lazygit --version

# If not found, install it:
# Get latest version number
LAZYGIT_VERSION="0.44.1"
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz
```

### Icons not showing (boxes or question marks)
- Make sure you installed a Nerd Font (Step 4)
- Set your terminal font to "JetBrainsMono Nerd Font Mono"
- **Restart your terminal completely** (not just open new tab)

### Telescope grep not working
```bash
# Check if ripgrep is installed
rg --version

# If not, install it
sudo apt install ripgrep
```

### Telescope file finder slow
```bash
# Install fd for faster file finding
sudo apt install fd-find
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

Then restart terminal or run:
```bash
source ~/.bashrc
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
