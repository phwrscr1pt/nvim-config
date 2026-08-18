require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Jump between changed hunks. In diff mode, fall back to Neovim's native
    -- ]c/[c change motions so diff navigation still works there.
    map("n", "]c", function()
      if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
    end, "Next git hunk")
    map("n", "[c", function()
      if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
    end, "Prev git hunk")

    -- Hunk actions (<leader>h = "Git hunks" in which-key).
    map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
    map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
    map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
    map("n", "<leader>hd", gs.diffthis, "Diff this file")
  end,
})
