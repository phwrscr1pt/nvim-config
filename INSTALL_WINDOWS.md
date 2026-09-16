# Installation Guide - Windows

Step-by-step guide for Windows 11. For the other platforms see
[INSTALL_LINUX.md](INSTALL_LINUX.md) and [INSTALL_MACOS.md](INSTALL_MACOS.md).

> **Important:** this config needs **Neovim 0.12+** (nvim-treesitter's `main`
> branch calls 0.12-only APIs and compiles parsers locally). The config's own
> gate only checks for 0.11, so a 0.11 machine loads it and then fails inside
> treesitter.

Neovim on Windows reads its config from `%LOCALAPPDATA%\nvim`. This guide clones
the repo somewhere you control and points a **junction** at it, so the repo stays
a normal git working copy you can pull and push from. No admin rights needed.

---

## TL;DR

This is the **complete** install including the clone. If you use it, skip Steps 7
and 8 of [SETUP.md](SETUP.md) (backup + clone — already done) and start at Step 9.

```powershell
winget install -e --id Neovim.Neovim
winget install -e --id Git.Git
winget install -e --id BurntSushi.ripgrep.MSVC
winget install -e --id sharkdp.fd
winget install -e --id JesseDuffield.lazygit
winget install -e --id DEVCOM.JetBrainsMonoNerdFont
winget install -e --id OpenJS.NodeJS
winget install -e --id GoLang.Go
winget install -e --id LLVM.LLVM
winget install -e --id 7zip.7zip
winget install -e --id tree-sitter.tree-sitter-cli

# CLOSE AND REOPEN Windows Terminal so PATH picks all of that up, then:
git clone https://github.com/phwrscr1pt/nvim-config.git "$env:USERPROFILE\nvim-config"
if (Test-Path "$env:LOCALAPPDATA\nvim") {
  Rename-Item "$env:LOCALAPPDATA\nvim" "nvim.backup.$(Get-Date -f yyyyMMddHHmmss)"
}
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$env:USERPROFILE\nvim-config"
nvim
```

---

## Requirements

| Need | winget id | Why |
|---|---|---|
| **Neovim 0.12+** | `Neovim.Neovim` | nvim-treesitter `main` |
| **git** | `Git.Git` | lazy.nvim bootstrap + `<Space>f` |
| **ripgrep** | `BurntSushi.ripgrep.MSVC` | `<Space>ps` live grep |
| **fd** *(optional)* | `sharkdp.fd` | faster Telescope file finding |
| **lazygit** | `JesseDuffield.lazygit` | `<Space>gg` |
| **Nerd Font** | `DEVCOM.JetBrainsMonoNerdFont` | icons everywhere |
| **Node** | `OpenJS.NodeJS` | Mason installs pyright + bashls |
| **Go** | `GoLang.Go` | Mason builds gopls |
| **LLVM/clang** | `LLVM.LLVM` | clangd **and** the C compiler tree-sitter needs |
| **7-Zip** | `7zip.7zip` | Mason needs it to extract archives on Windows |
| **tree-sitter CLI** | `tree-sitter.tree-sitter-cli` | parser compilation |
| **Clipboard** | *nothing* | works out of the box |

> Install the LSP toolchain **before** the first `nvim` launch, or some Mason
> servers will fail to install.

---

## Step-by-step

### Step 1: Core tools

```powershell
winget install -e --id Neovim.Neovim
winget install -e --id Git.Git
winget install -e --id BurntSushi.ripgrep.MSVC
winget install -e --id sharkdp.fd
winget install -e --id JesseDuffield.lazygit
winget install -e --id DEVCOM.JetBrainsMonoNerdFont
```

### Step 2: LSP toolchain (Mason needs these)

This config uses Neovim's native LSP (`vim.lsp`) via mason + mason-lspconfig +
nvim-lspconfig, and Mason installs `pyright`, `bashls`, `gopls`, `clangd` and
`lua_ls`. Some of those need a runtime present first:

```powershell
winget install -e --id OpenJS.NodeJS   # pyright + bashls (npm packages)
winget install -e --id GoLang.Go       # gopls is compiled with `go install`
winget install -e --id LLVM.LLVM       # clangd, and the C compiler tree-sitter needs
winget install -e --id 7zip.7zip       # Mason extracts archives with it on Windows
```

Visual Studio 2022 Build Tools with "Desktop development with C++" works instead
of LLVM if you already have it.

### Step 3: tree-sitter CLI

nvim-treesitter's `main` branch **compiles parsers locally** on launch (the old
branch downloaded prebuilt ones), so the CLI and a C compiler are both required.

```powershell
winget install -e --id tree-sitter.tree-sitter-cli
```

> Without the CLI or a compiler, parsers fail to build and syntax highlighting
> silently falls back to Vim's legacy regex highlighting — easy to miss. The
> treesitter text objects (`af`/`if`/`ac`/`ic`, `]f`/`[f`) stop working too.

The config points `CC` at `gcc` on Windows only (`lua/plugins/treesitter.lua`),
because the tree-sitter CLI defaults to MSVC (`cl`) there and does not fall back
to gcc/clang on its own. If you installed LLVM rather than msys2 gcc, set
`$env:CC = "clang"` instead.

### Step 4: Reopen the terminal, then check PATH

Close **all** Windows Terminal windows and open a fresh one so PATH updates.

```powershell
nvim --version        # must be 0.12.0 or later
git --version; rg --version; fd --version; lazygit --version
tree-sitter --version # must be >= 0.26.1
```

### Step 5: Clone the repo and point Neovim at it

**5.1 Clone wherever you want it to live:**

```powershell
git clone https://github.com/phwrscr1pt/nvim-config.git "$env:USERPROFILE\nvim-config"
```

**5.2 Back up any existing config (timestamped, so it is safe to re-run):**

```powershell
if (Test-Path "$env:LOCALAPPDATA\nvim") {
  Rename-Item "$env:LOCALAPPDATA\nvim" "nvim.backup.$(Get-Date -f yyyyMMddHHmmss)"
}
```

**5.3 Create the junction:**

```powershell
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$env:USERPROFILE\nvim-config"
```

**5.4 Verify:**

```powershell
Get-Item "$env:LOCALAPPDATA\nvim" | Select-Object LinkType, Target
# LinkType : Junction
# Target   : {C:\Users\<you>\nvim-config\}
```

`Target` is a `String[]`, so PowerShell prints it in braces, and the trailing
backslash is normal. Both are expected, not a sign something went wrong.

### Step 6: Nerd Font in Windows Terminal

Settings -> your profile -> Appearance -> Font face -> **`JetBrainsMono NFM`**
(NFM = Nerd Font Mono; that is the family name winget's
`DEVCOM.JetBrainsMonoNerdFont` registers).

> The same font is called **`JetBrainsMono Nerd Font Mono`** on macOS via
> Homebrew. Searching for the wrong string is why people think it failed to install.

---

**Next:** continue at [SETUP.md](SETUP.md) — it covers the first launch, LSP
servers, troubleshooting, updating and uninstalling for every platform.
If you used the TL;DR above, skip its Steps 7 and 8 and start at Step 9.

---

## Migrating from an older junction

If `%LOCALAPPDATA%\nvim` already points at a different checkout and you want to
repoint it at a fresh clone of this repo:

```powershell
$cfg = "$env:LOCALAPPDATA\nvim"
(Get-Item $cfg).Target            # note where it points - nothing there is deleted

cmd /c rmdir "$cfg"               # unlink ONLY

git clone https://github.com/phwrscr1pt/nvim-config.git "$env:USERPROFILE\nvim-config"
New-Item -ItemType Junction -Path $cfg -Target "$env:USERPROFILE\nvim-config"
```

> **Never `Remove-Item -Recurse` on a junction.** In Windows PowerShell 5.1 it
> recurses *through* the reparse point and deletes the contents of the directory
> the junction points at — i.e. your old config, not just the link. `cmd /c rmdir`
> with no `/s` removes the link entry and nothing else.

Your old checkout is untouched by the steps above. Keep it around until the new
one is proven, then delete it yourself.

## Windows-specific notes

- **The embedded terminal is PowerShell**, not a POSIX shell: `lua/plugins/toggleterm.lua`
  prefers `pwsh` and falls back to `powershell`. On macOS and Linux the same file
  leaves `shell` unset and you get your `$SHELL`.
- **`<C-Space>` arrives as `<Nul>`** in Windows Terminal, which is why
  `lua/plugins/blink.lua` maps `<Nul>` as well as the preset `<C-space>`.
- **Thai text**: Windows Terminal's AtlasEngine cannot shape Thai combining marks
  without drift. That is what the Neovide block in `lua/core/options.lua` is for —
  see [NEOVIDE_TH.md](NEOVIDE_TH.md). It is a Windows-only problem; Linux and
  macOS terminals shape Thai correctly.
- **git can be slow to spawn** here (OneDrive sync, antivirus, the `git.exe`
  wrapper), so `lua/plugins/nvim-tree.lua` raises nvim-tree's git timeout to 5s.

---

## Optional: Neovide as the default editor for code files

```powershell
reg import "$env:LOCALAPPDATA\nvim\windows\neovide-assoc-install.reg"
```

This registers a `Neovide.<ext>` ProgId for **113 extensions** (with icon and
Explorer type name), adds Neovide to "Open with", adds an "Open with Neovide"
right-click entry (under "Show more options" on Windows 11), lists Neovide in
Settings -> Default apps, and makes extensionless files (Dockerfile, Makefile,
LICENSE) open in Neovide.

If Neovide is not at `C:\Program Files\Neovide\neovide.exe`, regenerate the `.reg`
first — the script finds Neovide on PATH itself:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:LOCALAPPDATA\nvim\windows\gen-assoc.ps1"
```

### Windows 11 limitation - one manual step is unavoidable

Windows does **not** let the registry force a default app. The real default is
locked behind a `UserChoice` key carrying a **hash** that only Windows' own UI can
write. (Tested: with byte-identical registry entries, `.lua` opened Neovide
directly while `.go`, `.md` and `.txt` still showed the "Pick an app" dialog.)

After `reg import`, pick it once yourself, either way:

- **Many at once:** Settings -> Apps -> Default apps -> search **Neovide** -> all
  113 types are listed -> set them there.
- **One at a time, as you go:** right-click a file -> Open with -> Choose another
  app -> **Neovide** -> tick *Always use this app*.

### Side effects you should know about

- `.html` `.htm` `.svg` `.xml` `.txt` `.log` `.ps1` were bound to Edge / a browser /
  Notepad through `UserChoice`. The script **clears those** (it has to, or Neovide
  cannot be inserted), so those seven have **no default** afterwards and
  double-clicking shows the picker. Choose a browser there to get `.html`/`.svg` back.
- `.py` becomes **open for editing**, not **run**. Use `python file.py` to run.
- `.csv` no longer opens in Excel unless you pick Excel when prompted.
- `.bat` / `.cmd` are deliberately untouched — double-click still runs them.
- Each double-click opens a **new** Neovide window; window reuse is not implemented.

### Undo

```powershell
powershell -ExecutionPolicy Bypass -File "$env:LOCALAPPDATA\nvim\windows\undo-neovide-assoc.ps1"
```

> The `UserChoice` entries for those seven extensions cannot be restored
> automatically (they are hashed). Set them again in Settings -> Default apps.

---

## Uninstall / revert to your old config

```powershell
# Remove the junction WITHOUT touching what it points at.
$cfg = "$env:LOCALAPPDATA\nvim"
if (Test-Path $cfg) {
  if ((Get-Item $cfg).LinkType -eq 'Junction') { cmd /c rmdir "$cfg" }
  else { Remove-Item $cfg -Recurse -Force }
}

# Restore a backup made in Step 5.2 (adjust the timestamp)
Get-ChildItem "$env:LOCALAPPDATA" -Filter 'nvim.backup.*'
# Rename-Item "$env:LOCALAPPDATA\nvim.backup.<stamp>" "nvim"
```

To remove the plugins and LSP servers as well, see the Uninstall section of
[SETUP.md](SETUP.md) — and read its warning first, because on Windows the data
and state directories are the same path, so deleting it also takes your Mason
servers, undo history and Grapple tags.
