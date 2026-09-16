# Installation Guide - Linux (Kali / Debian)

Step-by-step guide for a Linux machine (written for **Kali**, works on any
Debian-based distro). For the other platforms see [INSTALL_MACOS.md](INSTALL_MACOS.md)
and [INSTALL_WINDOWS.md](INSTALL_WINDOWS.md).

> **Important:** this config needs **Neovim 0.12+** (nvim-treesitter's `main`
> branch calls 0.12-only APIs). Debian/Kali's apt `neovim` lags well behind, so
> Step 2 installs the latest official Neovim release into your home directory
> instead, leaving any system nvim untouched. (The config's own gate only checks
> for 0.11, so a 0.11 machine loads it and then fails inside treesitter.) Plugins are managed by **lazy.nvim**, which bootstraps itself on first
> launch (no `:PackerSync`).

---

## TL;DR - Copy-Paste for Fresh Kali

```bash
# 1. System dependencies (note: NOT the apt 'neovim' — it's too old)
sudo apt update && sudo apt install -y \
  git ripgrep fd-find nodejs npm curl unzip build-essential golang xclip

# 2. Neovim 0.12+ (latest stable), user-local — leaves any system nvim untouched
curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
mkdir -p ~/.local ~/.local/bin
tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local/ && rm nvim-linux-x86_64.tar.gz
ln -sf ~/.local/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
grep -q '.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"

# 3. tree-sitter CLI (nvim-treesitter main branch compiles parsers locally)
npm config get prefix >/dev/null 2>&1 || npm config set prefix ~/.npm-global
grep -q '.npm-global/bin' ~/.zshrc || echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.npm-global/bin:$PATH"
npm install -g tree-sitter-cli

# 4. fd is named 'fdfind' on Debian — expose it as 'fd' for Telescope
ln -sf "$(command -v fdfind)" ~/.local/bin/fd

# 5. lazygit
LAZYGIT_VERSION="0.44.1"
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit lazygit.tar.gz

# 6. Nerd Font
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o JetBrainsMono.zip && rm JetBrainsMono.zip && fc-cache -fv && cd ~

# 7. Clone this config, then launch — lazy.nvim installs everything on first run
git clone https://github.com/phwrscr1pt/nvim-config.git ~/.config/nvim
nvim   # wait for the Lazy UI to finish, then :qa and reopen
```

**After running the above:** set your terminal font to **"JetBrainsMono Nerd Font
Mono"**, restart the terminal, then run `nvim`.

---

## Requirements

- **Neovim 0.12+** — required by nvim-treesitter `main`
- Git
- **tree-sitter CLI + a C compiler** (gcc from `build-essential`) — treesitter compiles parsers locally
- Node.js + npm (for the tree-sitter CLI and some LSP servers)
- ripgrep (Telescope live grep)
- fd / fd-find (Telescope file finder)
- lazygit (Git UI)
- xclip / xsel or wl-clipboard (system clipboard `"+`)
- A Nerd Font (icons)
- Go (for the gopls LSP server)

---

## Fresh Kali Linux Installation (Complete Guide)

### Step 1: Update + install system dependencies

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git ripgrep fd-find nodejs npm curl unzip build-essential golang xclip
```

> Do **not** rely on the apt `neovim` package — it's 0.11.x and this config needs
> 0.12+. Step 2 installs a newer Neovim in your home directory. (Installing the
> apt one too does no harm; the home-directory one just needs to win on `PATH`.)

### Step 2: Install Neovim 0.12+ (latest stable, user-local)

```bash
curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
mkdir -p ~/.local ~/.local/bin
tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local/
rm nvim-linux-x86_64.tar.gz
ln -sf ~/.local/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
```

Make `~/.local/bin` win on your PATH (use `~/.bashrc` if your shell is bash):
```bash
grep -q '.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify — must be 0.12.0 or later:
```bash
nvim --version | head -1
```

> To revert later: `rm ~/.local/bin/nvim ~/.local/nvim-linux-x86_64 -r` — your
> system nvim (if installed) is untouched.

### Step 3: tree-sitter CLI + compiler

nvim-treesitter's `main` branch compiles each parser locally, so it needs the
tree-sitter CLI and a C compiler (`gcc`, from `build-essential` in Step 1).

```bash
# Install the CLI user-level (no sudo). Set an npm prefix first if you don't have one:
npm config get prefix || npm config set prefix ~/.npm-global
grep -q '.npm-global/bin' ~/.zshrc || echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
npm install -g tree-sitter-cli
tree-sitter --version   # must be >= 0.26.1 - nvim-treesitter `main` rejects older CLIs
#
# If npm ships an older one, install the release binary instead:
#   curl -fLO https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
#   gunzip tree-sitter-linux-x64.gz && install -m755 tree-sitter-linux-x64 ~/.local/bin/tree-sitter
```

### Step 4: Expose fd (Debian names it fdfind)

```bash
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
```

### Step 5: Install lazygit

(Check <https://github.com/jesseduffield/lazygit/releases> and bump this if it is stale.)

```bash
LAZYGIT_VERSION="0.44.1"
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz
lazygit --version   # verify
```

### Step 6: Install a Nerd Font (do this BEFORE opening Neovim)

```bash
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
cd ~
```

Then set your terminal font to **"JetBrainsMono Nerd Font Mono"**:
- **Kali Terminal / QTerminal**: Preferences → Appearance/Font

**Next:** continue at [SETUP.md](SETUP.md) — it covers the clone, first launch,
LSP servers, troubleshooting, updating and uninstalling for every platform.
If you used the TL;DR above, skip its Steps 7 and 8 and start at Step 9.
