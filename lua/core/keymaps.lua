-- Move lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Clear search highlight (hlsearch is on) AND dismiss flash.nvim's f/t/F/T
-- char-mode highlight. The leading <Esc> in the RHS is intentional and MUST
-- stay: flash hides its char highlight from a vim.on_key hook that inspects
-- the POST-mapping key. Feeding a bare (noremap) <Esc> first lets flash's own
-- handler see <Esc> and self-clear; <Cmd>nohlsearch<CR> then clears the search
-- highlight. Do NOT collapse to just "<Cmd>nohlsearch<CR>" — flash would only
-- ever see <Cmd>, so the f/t highlight would linger until the cursor moves.
vim.keymap.set("n", "<Esc>", "<Esc><Cmd>nohlsearch<CR>", { desc = "Clear search & flash highlight" })

-- Save file
vim.keymap.set("n", "<A-s>", ":noa w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

-- LazyGit
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })

-- System clipboard (explicit + register).
-- On Linux the "+ register needs a provider installed: xclip or xsel (X11), or
-- wl-clipboard (Wayland). Without one these maps silently do nothing --
-- `:checkhealth provider` will say so. On Windows it works out of the box.
-- <leader>P (capital) is used for paste to avoid a prefix clash with <leader>ps (live grep).
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })   -- Space y
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })       -- Space Y
vim.keymap.set({ "n", "v" }, "<leader>P", [["+p]], { desc = "Paste from clipboard" }) -- Space P

-- Copy the current file's path to the system clipboard. Works in ANY buffer,
-- unlike nvim-tree's in-tree y/Y/gy which only fire when the tree is focused.
-- Guards nameless / non-file / directory buffers so we never overwrite the
-- clipboard with an empty string, and derives every form from the buffer's
-- ABSOLUTE name so the relative form stays correct even after project.nvim
-- changes the global cwd.
local function copy_path(modifier, label)
  local full = vim.api.nvim_buf_get_name(0)
  if vim.bo.buftype ~= "" or full == "" or vim.fn.isdirectory(full) == 1 then
    vim.notify("No file path for this buffer", vim.log.levels.WARN)
    return
  end
  local path = vim.fn.fnamemodify(full, modifier)
  if path == "" then
    vim.notify("No file path for this buffer", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", path)
  vim.notify("Copied " .. label .. ": " .. path)
end

vim.keymap.set("n", "<leader>cp", function() copy_path(":.", "relative path") end, { desc = "Copy relative path" })
vim.keymap.set("n", "<leader>cP", function() copy_path(":p", "absolute path") end, { desc = "Copy absolute path" })
vim.keymap.set("n", "<leader>cn", function() copy_path(":t", "filename") end, { desc = "Copy filename" })
vim.keymap.set("n", "<leader>cd", function() copy_path(":p:h", "directory") end, { desc = "Copy dir (absolute)" })
