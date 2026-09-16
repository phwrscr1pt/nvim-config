# Neovide — GUI สำหรับงานไทย (คู่มือย่อ)

> config นี้ใช้ **Neovide** เป็นตัวหลักเวลาทำงานภาษาไทย ไฟล์นี้รวมทุกอย่างเกี่ยวกับ Neovide:
> ทำไมต้องใช้ · ฟอนต์ · ปรับขนาด · ย่อ/ขยายจอ · งานไทยกับ Claude Code

---

## 1. Neovide คืออะไร + ทำไมต้องใช้

**Neovide** เป็น GUI ของ Neovim — เปิดเป็นหน้าต่างจริง (ไม่ได้รันใน terminal) วาดจอด้วย engine ของตัวเอง (Skia/Swash)

**ทำไม config นี้ใช้ Neovide สำหรับงานไทย:** renderer ของ terminal (เช่น Windows Terminal) วาดสระ/วรรณยุกต์ไทย (Unicode combining marks) ให้เกาะตรงตำแหน่งในกริดไม่ได้ → มาร์คลอย/ซ้อนกัน แต่ Neovide shape glyph เองได้ถูกต้อง → ไทยเรียงสวย

- **แก้ไฟล์ไทย** → Neovide
- **เทอร์มินัลในตัว (`<A-w>` toggleterm) ใน Neovide** → ไทยก็อ่านออก
- nvim ใน terminal (WT) → เอาไว้ SSH/lab (ไทยพออ่านได้ด้วย fallback Noto Sans Thai แต่ไม่สวยเท่า Neovide)

## 2. ติดตั้ง + เปิด

- **ติดตั้ง:** `winget install Neovide.Neovide` (เวอร์ชันที่ใช้อยู่: 0.16.2)
- **เปิด:** พิมพ์ `neovide <ไฟล์>` ที่ terminal หรือเปิดจาก Start menu
- อ่าน config เดียวกับ nvim (ผ่าน junction `%LOCALAPPDATA%\nvim`) — ไม่ต้องตั้งค่าซ้ำ

## 3. ฟอนต์ (guifont)

```lua
vim.o.guifont = "JetBrainsMono NFM,Noto Sans Thai:h11"
```

- `JetBrainsMono NFM` = ฟอนต์หลัก (วาด Latin/อังกฤษ + ไอคอน Nerd Font)
- `Noto Sans Thai` = fallback สำหรับตัวที่ฟอนต์หลักไม่มี (= อักษรไทย มี GPOS anchor ดี → มาร์คเกาะตรง)
- `:h11` = ขนาด (points) — **ใส่ทศนิยมได้** เช่น `:h10.5`

## 4. ปรับขนาดฟอนต์ — เปลี่ยนเลขหลัง `:h`

ลองสดก่อน:
```vim
:set guifont=JetBrainsMono\ NFM,Noto\ Sans\ Thai:h10
```

> ⚠️ **สำคัญ:** Neovide ใช้ขนาดนี้กับ **ทุกฟอนต์พร้อมกัน** — ลด `:h` ที ตัวอังกฤษเล็กลง **ตัวไทยก็เล็กลงตาม** ปรับขนาดแยกเฉพาะภาษาเดียวในสตริงเดียว **ทำไม่ได้** (เป็นข้อจำกัดของ Neovide เอง)

## 5. ย่อ/ขยายทั้งจอ — `neovide_scale_factor`

ถ้าอยากย่อ/ขยายทั้ง UI (ตัวอักษร + ทุกอย่าง) โดยไม่ยุ่งกับ guifont ใช้ตัวนี้ (config ตั้งไว้ **0.9 = 90%**):

```vim
:lua vim.g.neovide_scale_factor = 0.9
```

- `> 1.0` = ใหญ่ขึ้น · `< 1.0` = เล็กลง · Neovide ปรับให้ทันทีที่รันคำสั่ง (ต้อง Neovide 0.10.2+)
- ลองค่าสดๆ จนถูกใจ แล้วค่อยเอาไปใส่ถาวรใน `options.lua`

**อยากได้ปุ่ม zoom สด** (Ctrl+= ขยาย / Ctrl+- ย่อ / Ctrl+0 รีเซ็ต) — map เพิ่มเองได้:
```lua
if vim.g.neovide then
  local function rescale(factor)
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) * factor
  end
  vim.keymap.set("n", "<C-=>", function() rescale(1.1) end)       -- ขยาย
  vim.keymap.set("n", "<C-->", function() rescale(1 / 1.1) end)   -- ย่อ (คูณกลับ → ไม่มีทางถึง 0/ติดลบ)
  vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1 end) -- รีเซ็ตเป็น 100%
end
```

## 6. ที่ตั้งใน config

`lua/core/options.lua`:
```lua
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono NFM,Noto Sans Thai:h11"
  vim.g.neovide_scale_factor = 0.9
end
```

guard `if vim.g.neovide` = ค่าพวกนี้ **มีผลเฉพาะตอนเปิดใน Neovide** ส่วน nvim ใน terminal ไม่โดนแตะ

## 7. งานไทย + Claude Code

- ในตัว Neovide เทอร์มินัลในตัว (`<A-w>`) แสดงไทยอ่านออก
- แต่ถ้าเปิด **Claude Code** แล้วพิมพ์ไทยในช่อง input ของมันจะเพี้ยน — อันนั้นเป็น **บั๊กของ Claude Code เอง** (คำนวณความกว้างของตัวที่มีสระ/วรรณยุกต์ผิด) แก้ด้วยฟอนต์ไม่ได้ → กด **`Ctrl+G`** เปิด editor เขียน prompt ไทยแทน (หรือ `claude -p` piped จากไฟล์)

## Quick reference

| อยากทำ | คำสั่ง |
|--------|--------|
| ปรับขนาดฟอนต์ (มีผลทุกภาษา) | `:set guifont=JetBrainsMono\ NFM,Noto\ Sans\ Thai:hN` |
| ย่อ/ขยายทั้งจอ | `:lua vim.g.neovide_scale_factor = N` |
| รีเซ็ต scale เป็น 100% | `:lua vim.g.neovide_scale_factor = 1` |
| พิมพ์ไทยใส่ Claude Code | กด `Ctrl+G` เขียน prompt ใน editor |
