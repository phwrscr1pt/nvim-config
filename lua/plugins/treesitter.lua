-- nvim-treesitter (main branch) — Neovim 0.12 API.
-- Unlike the old master branch there is no setup{ensure_installed, highlight}.
-- Instead: install parsers via require("nvim-treesitter").install(), and turn on
-- highlighting/indent per buffer with the native vim.treesitter APIs.
local ts = require("nvim-treesitter")

-- On Windows the tree-sitter CLI defaults to MSVC (cl) and does NOT fall back to
-- gcc/clang, so parser compilation fails with "program not found". Point it at
-- the msys2 gcc that's on PATH -- only if the user hasn't set a compiler already.
if vim.fn.has("win32") == 1 and (vim.env.CC == nil or vim.env.CC == "") then
  vim.env.CC = "gcc"
end

-- Parsers to keep installed (compiled locally on first run, asynchronously).
local ensure = {
  "lua", "vim", "vimdoc", "query", -- Neovim itself
  "python", "bash", "go", "c", "cpp", "rust", -- languages you work in
  "markdown", "markdown_inline",
  "json", "yaml", "toml",
}

if ts.install then
  ts.install(ensure)
end

-- Start Tree-sitter highlighting for any buffer whose parser is installed
-- (vim.treesitter.start errors when the parser is missing, hence the pcall; a
-- parser that finishes installing lights up when the buffer's filetype next
-- fires, e.g. on reopen).
-- Enable Tree-sitter INDENT only for languages that actually ship an indents
-- query -- some parsers (e.g. vim, vimdoc) have none, and pointing indentexpr at
-- Tree-sitter for them would zero out Vim's own working indentation.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and ts.indentexpr then
      local ok, query = pcall(vim.treesitter.query.get, lang, "indents")
      if ok and query then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

-- Tree-sitter text objects (main branch; loaded as a dependency of the spec
-- above). Adds structure-aware objects the built-ins can't do: vif/vaf
-- (inside/around a function), vic/vac (class), and ]f/[f to jump between
-- functions. This is exactly what NVIM_GUIDE_TH §3 / VIM_PRACTICE.md used to
-- say was unavailable (no mini.ai / treesitter-textobjects) — now it works.
require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
local sel = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
for _, m in ipairs({ "x", "o" }) do
  vim.keymap.set(m, "af", function() sel.select_textobject("@function.outer", "textobjects") end, { desc = "around function" })
  vim.keymap.set(m, "if", function() sel.select_textobject("@function.inner", "textobjects") end, { desc = "inside function" })
  vim.keymap.set(m, "ac", function() sel.select_textobject("@class.outer", "textobjects") end, { desc = "around class" })
  vim.keymap.set(m, "ic", function() sel.select_textobject("@class.inner", "textobjects") end, { desc = "inside class" })
end
vim.keymap.set("n", "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function" })
vim.keymap.set("n", "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function" })
