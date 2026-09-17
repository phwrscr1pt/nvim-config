<!-- English twin: INSTALL_MACOS.md — แก้คำสั่งหรือ code fence ที่นี่แล้วต้องแก้อีกไฟล์ให้ตรงกันด้วย -->
# คู่มือติดตั้ง Neovim บน macOS

สำหรับเครื่อง Mac (สมมติว่าเป็น Apple Silicon ส่วน Intel จะบอกจุดที่ต่างไว้ในแต่ละหัวข้อ)
แพลตฟอร์มอื่นดูที่ [INSTALL_LINUX.md](INSTALL_LINUX.md) และ [INSTALL_WINDOWS.md](INSTALL_WINDOWS.md)

> **สำคัญ:** config นี้ต้องใช้ **Neovim 0.12+** (nvim-treesitter branch `main` เรียก API
> ที่มีเฉพาะ 0.12) formula `neovim` ของ Homebrew ตามต้นน้ำใกล้มาก เพราะฉะนั้น
> `brew install neovim` พอแล้ว **ไม่ต้อง** ใช้ nightly หรือโหลด tarball เอง
> (ตัว gate ใน config เช็คแค่ 0.11 เครื่องที่เป็น 0.11 จะโหลดผ่านแล้วไปพังที่ treesitter แทน)

> **ข่าวดีสำหรับ Mac:** Lua ใน config นี้ไม่ต้องแก้สักบรรทัดเพื่อให้ใช้บน macOS ได้
> ทั้ง repo มี branch ที่แยกตาม OS อยู่แค่ 2 จุด ทั้งคู่เป็น `vim.fn.has("win32")`
> และทั้งคู่ตกไปทางที่ macOS ต้องการพอดี — ใช้ `$SHELL` ของคุณสำหรับ terminal ในตัว
> และใช้ `clang` ของ Apple คอมไพล์ parser ของ tree-sitter

---

## TL;DR — ก๊อปวางสำหรับเครื่องใหม่

ชุดนี้ติดตั้ง **ครบรวม clone แล้ว** ถ้าใช้ชุดนี้ให้**ข้าม Step 7 กับ 8 ของ
[SETUP.md](SETUP.md)** (backup + clone ทำไปแล้ว) แล้วเริ่มที่ Step 9 เลย

```bash
# 1. Compiler + git. Do this FIRST: a fresh Mac's /usr/bin/git is an Xcode stub
#    that pops a GUI dialog and fails, which would break the plugin bootstrap.
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# 2. Homebrew, and put it on PATH (Apple Silicon; Intel uses /usr/local)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Everything else
brew install neovim ripgrep fd node go lazygit tree-sitter-cli
brew install --cask font-jetbrains-mono-nerd-font

# 4. Verify before going further
nvim --version | head -1     # must be 0.12.0 or later
tree-sitter --version        # must be >= 0.26.1

# 5. Clone this config, then launch — lazy.nvim installs everything on first run
git clone https://github.com/phwrscr1pt/nvim-config.git ~/.config/nvim
nvim
```

---

## สิ่งที่ต้องมี

| ต้องมี | ติดตั้งด้วย | ใช้ทำอะไร |
|---|---|---|
| **Neovim 0.12+** | `brew install neovim` | nvim-treesitter `main` |
| **git** | Xcode CLT (ข้างบน) | bootstrap lazy.nvim + `<Space>f` |
| **C compiler** | Xcode CLT (`clang`) | tree-sitter คอมไพล์ parser ในเครื่อง |
| **tree-sitter CLI >= 0.26.1** | `brew install tree-sitter-cli` | คอมไพล์ parser |
| **ripgrep** | `brew install ripgrep` | `<Space>ps` live grep |
| **fd** *(ไม่บังคับ)* | `brew install fd` | Telescope หาไฟล์เร็วขึ้น |
| **lazygit** | `brew install lazygit` | `<Space>gg` |
| **Node** | `brew install node` | Mason ลง pyright + bashls |
| **Go** | `brew install go` | Mason build gopls |
| **Nerd Font** | `brew install --cask font-jetbrains-mono-nerd-font` | ไอคอนใน tree, statusline, เมนู completion |
| **Clipboard** | *ไม่ต้องลงอะไร* | macOS ใช้ `pbcopy`/`pbpaste` ที่มีมาในตัว |

> **อย่าตั้ง `CC` บน Mac** `/usr/bin/gcc` เป็นแค่ shim ของ clang ไม่ได้อะไรเพิ่ม
> ส่วน tree-sitter CLI ใช้ `cc` เป็น default อยู่แล้วซึ่งก็คือ Apple clang
> บรรทัด `vim.env.CC = "gcc"` ใน `lua/plugins/treesitter.lua` ถูก gate ด้วย `win32`
> จึงถูกข้ามบน Mac อย่างถูกต้อง

---

## ติดตั้งแบบละเอียด

### ขั้นที่ 1 — Xcode Command Line Tools

```bash
xcode-select -p || xcode-select --install   # GUI dialog; wait for it to finish
git --version && clang --version | head -1  # both must answer with NO dialog
```

อันนี้เทียบเท่า `build-essential` บน Debian ให้ทั้ง `git` **และ** `cc`

### ขั้นที่ 2 — Homebrew และการใส่ PATH

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile   # Intel: /usr/local/bin/brew
eval "$(/opt/homebrew/bin/brew shellenv)"
```

แก้ PATH ที่ `~/.zprofile` หรือ `~/.zshrc` เท่านั้น **ห้ามใส่ใน `~/.zshenv`** เพราะ
`/etc/zprofile` จะเรียก `path_helper` ซึ่งจัดลำดับ PATH ใหม่และลบผลของ `~/.zshenv` ทิ้งเงียบ ๆ

เรื่องนี้สำคัญเพราะ config เรียกไบนารีแบบไม่ระบุ path เต็มอยู่ 5 ตัว: `git`,
`tree-sitter`, `lazygit`, `rg` และ `claude`

### ขั้นที่ 3 — ลง Neovim และที่เหลือ

```bash
brew info neovim                 # confirm stable is 0.12.x before installing
brew install neovim ripgrep fd node go lazygit tree-sitter-cli
```

**อย่าใช้** `brew install --HEAD neovim` เพราะมันจะคอมไพล์จาก source

ถ้าวันไหน stable ของ brew ยังเป็น 0.11.x อยู่ ให้ใช้ build ทางการของ macOS แทน:

```bash
ARCH=$([ "$(uname -m)" = arm64 ] && echo arm64 || echo x86_64)
curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-$ARCH.tar.gz
mkdir -p ~/.local ~/.local/bin
tar -xzf nvim-macos-$ARCH.tar.gz -C ~/.local/ && rm nvim-macos-$ARCH.tar.gz
ln -sf ~/.local/nvim-macos-$ARCH/bin/nvim ~/.local/bin/nvim
grep -q '.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh -l && nvim --version | head -1
```

ถ้าโหลด tarball นั้นด้วย **เบราว์เซอร์** แทน curl ต้องรัน `xattr -c nvim-macos-$ARCH.tar.gz`
ก่อน เพื่อล้างแฟล็ก quarantine ของ Gatekeeper — ถ้าโหลดด้วย curl ไม่ต้อง เพราะ curl ไม่ใส่แฟล็กนั้น

> **หมายเหตุ:** บน macOS ไม่มี `fdfind` การเปลี่ยนชื่อในคู่มือ Linux เป็นเรื่องเฉพาะ
> การแพ็กเกจของ Debian ส่วน Homebrew ลงมาเป็นชื่อ `fd` ตรง ๆ อยู่แล้ว

### ขั้นที่ 4 — Nerd Font

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

**ไม่ต้อง `brew tap`** เพราะ tap `homebrew/cask-fonts` ถูกยุบรวมเข้า `homebrew/cask`
ตั้งแต่ปี 2024 แล้ว คู่มือเก่า ๆ ที่ยังบอกให้ tap คือข้อมูลค้าง

จากนั้นตั้งฟอนต์ของ terminal เป็น **`JetBrainsMono Nerd Font Mono`** แล้ว
**ปิดโปรแกรม terminal ให้สนิทด้วย Cmd-Q** — เปิดแท็บใหม่ไม่พอ เพราะฟอนต์ของ profile
ถูกอ่านตอนเปิดแอป นี่คือสาเหตุอันดับหนึ่งของอาการ "ลงฟอนต์แล้วแต่ยังเห็นเป็นกล่อง"

> ฟอนต์ตัวเดียวกันนี้บน Windows ชื่อ **`JetBrainsMono NFM`** (ชื่อที่ winget ลงทะเบียนไว้)
> การค้นหาด้วยชื่อผิดคือเหตุผลที่หลายคนคิดว่าลงไม่สำเร็จ

มีสามจุดใน config ที่สมมติว่าคุณใช้ฟอนต์นี้: `nerd_font_variant` ใน
`lua/plugins/blink.lua`, glyph ที่เขียนตายตัวใน `lua/plugins/nvim-tree.lua` และ
icon override ใน `lua/plugins/devicons.lua`

### ขั้นที่ 5 — Terminal

Terminal.app รองรับแค่ 256 สี ทำให้ `termguicolors` ได้สี onedark ที่เพี้ยนและไม่มี
undercurl ใต้ diagnostic ใช้ตัวอื่นแทน:

```bash
brew install --cask wezterm      # or: ghostty, kitty
```

> **stable cask ของ WezTerm เป็น build เดือน ก.พ. 2024** ถ้า macOS ของคุณใหม่กว่านั้นมาก
> อาจใช้ `brew install --cask wezterm@nightly` ดีกว่า ซึ่งเป็นตัวที่ผู้ใช้ WezTerm
> ส่วนใหญ่รันกันจริง

**ทำไมถึงสำคัญกับ keymap:** macOS ตั้งให้ Option เป็นปุ่มผสมอักขระโดย default
เพราะฉะนั้น `<A-s>` / `<A-w>` / `<A-q>` จะพิมพ์ `ß` / `∑` / `œ` ออกมาแทนที่จะทำงาน

| Terminal | ต้องตั้งอะไร |
|---|---|
| **WezTerm** | ไม่ต้องตั้ง — Option ซ้ายส่ง Esc+ อยู่แล้ว |
| **Ghostty** | `macos-option-as-alt = left` |
| **kitty** | `macos_option_as_alt left` |
| **iTerm2** | Settings → Profiles → Keys → Left Option key = `Esc+` |
| **Terminal.app** | Settings → Profiles → Keyboard → "Use Option as Meta key" |

ใช้แบบ **ซ้ายอย่างเดียว** เพื่อให้ Option ขวายังพิมพ์ é / – / © ได้ตามปกติ

> **ห้าม** `export TERM=xterm-256color` บน macOS มันไม่ได้เพิ่ม truecolor อะไรเลย
> แถมทำให้ kitty (`xterm-kitty`) กับ Ghostty (`xterm-ghostty`) พัง
> เช็คด้วย `echo $COLORTERM` — ต้องได้ `truecolor`

### ขั้นที่ 6 — Claude CLI (ไม่บังคับ ใช้กับ `<Space>a*`)

ติดตั้งตามเอกสารทางการ จุดที่ต้องระวังบน macOS: ตัวติดตั้งวาง launcher ไว้ที่
`~/.local/bin` ซึ่ง **ไม่ได้อยู่ใน PATH ของ zsh โดย default**

```bash
grep -q '.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh -l && claude --version
```

เช็คสิ่งที่ **Neovim** เห็น ไม่ใช่สิ่งที่ shell เห็น: `:echo exepath('claude')`
ถ้าได้สตริงว่างแปลว่ายังไม่เจอ

---

**ขั้นต่อไป:** ไปต่อที่ [SETUP.md](SETUP.md) — ครอบคลุมการ clone, เปิดครั้งแรก,
LSP server, แก้ปัญหา, อัปเดต และถอนการติดตั้ง ใช้ร่วมกันทุกแพลตฟอร์ม
ถ้าใช้ TL;DR ข้างบนไปแล้ว ให้ข้าม Step 7 กับ 8 ของมันแล้วเริ่มที่ Step 9

---

## เรื่องที่เจอเฉพาะบน macOS

เรียงตามโอกาสที่จะเจอ

1. **กด `j`/`k` ค้างแล้วเลื่อนช้ามาก** ไปที่ System Settings → Keyboard ตั้ง
   "Key repeat rate" เป็น Fast และ "Delay until repeat" เป็น Short
2. **`<A-w>` / `<A-q>` / `<A-s>` ไม่ทำงานตอน input source เป็นภาษาไทย**
   Option ซ้าย+w จะส่งปุ่มตาม layout ไทย ไม่ใช่ `^[w` อันนี้เป็นพฤติกรรมของ
   input source ของ macOS เอง **แก้ที่ไฟล์ config ไม่ได้** ให้ใช้ **`<C-\>`**
   เปิด terminal แบบลอยแทน — map ไว้ในโหมด normal เพื่อการนี้โดยเฉพาะ
   (`<C-\><C-n>` ยังใช้ออกจาก terminal mode ได้ตามปกติ เพราะ `<C-\>` เดี่ยว ๆ
   map เฉพาะโหมด normal เท่านั้น)
3. **Ctrl+Space เลิกเรียก completion ทันทีที่เพิ่ม input source ตัวที่สอง**
   macOS จองปุ่มนี้ไว้ให้ "Select the previous input source" ปิดได้ที่
   System Settings → Keyboard → Keyboard Shortcuts → Input Sources หรือจะ map
   ปุ่มอื่นใน terminal ก็ได้ ทั้งนี้ completion ยังเด้งอัตโนมัติอยู่เหมือนเดิม
4. **สีเพี้ยนเมื่ออยู่ใน tmux แม้จะใช้ terminal ที่ดี** ให้ใช้ `tmux-256color`
   คู่กับ `set -as terminal-features ",*:RGB"` ไม่ใช่ `screen-256color`
5. **parser คอมไพล์ไม่ผ่าน ขึ้น error เรื่อง `arm64e.x1`** ถ้าเห็นแบบนี้

   ```
   ld: tapi error: malformed file
   .../MacOSX27.0.sdk/usr/lib/libSystem.B.tbd: error: unknown architecture
                      arm64e.x1-macos, arm64e.x1-maccatalyst ]
   ```

   **นี่ไม่ใช่ปัญหาของ Neovim — C toolchain ทั้งเครื่องพัง** พิสูจน์ได้ใน 5 วินาที:

   ```bash
   echo 'int main(void){return 0;}' > /tmp/t.c && cc /tmp/t.c -o /tmp/t
   ```

   ถ้าอันนี้พังด้วย แปลว่า macOS ติดตั้ง SDK ที่ใหม่กว่าที่ linker ของ Command Line
   Tools รู้จัก — `xcrun` จะเลือก SDK ใหม่สุดที่มีเสมอ แล้ว `ld` รุ่นเก่าอ่านไฟล์
   `.tbd` ของมันไม่ออก เช็คด้วย `ls /Library/Developer/CommandLineTools/SDKs/`
   และ `xcrun --show-sdk-version`

   *แก้ที่ต้นเหตุ:* อัปเดต macOS แล้วลง
   `sudo softwareupdate --install "Command Line Tools for Xcode <เวอร์ชัน>"`
   ให้ linker ตรงรุ่นกับ SDK
   *workaround ระหว่างนั้น:* ตรึง SDK ไว้ที่รุ่นที่ตรงกับ clang ของคุณ
   (ดู target ได้จาก `clang --version`)

   ```bash
   echo 'export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX26.sdk' >> ~/.zshenv
   exec zsh
   ```

   ใส่ใน `~/.zshenv` ไม่ใช่ `~/.zprofile` เพราะ build tool เรียก shell แบบ
   non-interactive ซึ่งอ่านแค่ zshenv — และ `SDKROOT` ไม่ใช่ PATH จึงไม่เกี่ยวกับ
   คำเตือนเรื่อง `path_helper` ที่อื่นในคู่มือนี้ ลบบรรทัดนี้ทิ้งเมื่อแก้ที่ต้นเหตุ
   เสร็จแล้วและ `cc /tmp/t.c -o /tmp/t` ยังผ่าน

6. **treesitter พังเงียบ ๆ** ถ้า `tree-sitter` หรือ `cc` ไม่อยู่ใน PATH ที่ Neovim เห็น
   คุณจะยังได้ syntax highlight แบบ regex ของ Vim เดิมอยู่ เลยสังเกตยาก — แต่
   `af`/`if`/`ac`/`ic`, `]f`/`[f` และ `<Space>or` จะเลิกทำงานทั้งหมด
   ตรวจด้วย `:checkhealth nvim-treesitter` และจำไว้ว่า parser **คอมไพล์เบื้องหลัง
   แบบ async** ตอนเปิดครั้งแรก — `nvim --headless -c 'qa!'` จะออกก่อนคอมไพล์เสร็จ
   ให้เปิด `nvim` ค้างไว้สักสองสามนาที แล้วค่อยนับด้วย
   `ls ~/.local/share/nvim/site/parser/ | wc -l` (ควรได้ 15)
7. **หน้าต่างขออนุญาตของ macOS ทำให้โฟลเดอร์ดูเหมือนว่าง** ครั้งแรกที่ terminal
   แตะ `~/Desktop`, `~/Documents` หรือ `~/Downloads` macOS จะถาม ถ้ากดปฏิเสธ
   การอ่านโฟลเดอร์จะล้มเหลว แล้ว tree, Telescope และ project.nvim จะว่างเปล่า
   โดยไม่มี error ตรวจด้วย
   `:lua vim.print(vim.fn.readdir(vim.fn.expand('~/Desktop')))` — ไม่ใช่
   `isdirectory()` เพราะมันยังคืนค่า 1 อยู่ วิธีเลี่ยงที่ง่ายที่สุดคือเก็บงานไว้ที่ `~/code`
8. **ไม่มีปุ่ม Esc จริง** (MacBook Pro Touch Bar ปี 2016-2019): System Settings →
   Keyboard → Keyboard Shortcuts → Modifier Keys → Caps Lock = Escape
   คุ้มที่จะทำบน Mac ทุกเครื่อง
9. **Neovim ที่เปิดจาก GUI มองไม่เห็น PATH ของคุณ** แอปที่เปิดจาก Finder หรือ
   Spotlight จะได้ PATH ขั้นต่ำของ launchd ไม่ใช่ของ `~/.zprofile`
   ถ้าพิมพ์ `nvim` ใน terminal ตามปกติจะไม่เจอปัญหานี้

## เรื่องที่ดูเหมือนปัญหาของ macOS แต่ไม่ใช่

- **บล็อก Neovide/ไทย** ใน `lua/core/options.lua` เป็นการแก้ปัญหาของ
  **Windows Terminal** โดยเฉพาะ macOS วางสระ/วรรณยุกต์ถูกต้องอยู่แล้วผ่าน
  CoreText และ HarfBuzz เพราะฉะนั้น **ไม่ต้องลง Neovide บน Mac** และยังไม่ต้องเจอ
  ข้อเสียเรื่องตารางไม่ตรงคอลัมน์จากฟอนต์ proportional ด้วย
  แต่ `cell = "raw"` ใน `lua/plugins/render-markdown.lua` **ต้องเก็บไว้** เพราะมันแก้
  การคำนวณความกว้างใน Lua ของ plugin เอง ไม่เกี่ยวกับ OS
- **xclip / xsel / wl-clipboard** เป็นเรื่องของ Linux ล้วน ๆ ไม่ต้องลงอะไร
  ตรวจด้วย `:checkhealth vim.provider`
- **clangd ของ Mason บน Apple Silicon** เป็น universal binary ที่มี arm64 native
  อยู่ในตัว ไม่ต้องใช้ Rosetta ที่ไหนเลยในชุดนี้
- **`<C-s>` ไม่ได้ถูก flow control กิน** TUI ของ Neovim เคลียร์ IXON ให้แล้ว
  กด Ctrl+S แล้วเซฟได้ตามปกติ
