-- Native LSP setup for Neovim 0.11+/0.12 -- lsp-zero has been removed.
--
-- Why: lsp-zero.nvim is declared "Dead" upstream (Neovim 0.11 made it
-- unnecessary), and its mason-lspconfig v1 `handlers` API was removed in
-- mason-lspconfig v2 -- so the old handler block was silently ignored and the
-- LSP keymaps never attached. This uses the native pipeline instead:
--   mason (install servers) -> mason-lspconfig automatic_enable (vim.lsp.enable)
--   -> vim.lsp.config for defaults/overrides -> LspAttach for buffer keymaps.

require("mason").setup({})

-- Advertise blink.cmp's completion capabilities to every server.
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

-- lua_ls: know about the `vim` global and the Neovim runtime so editing this
-- config is diagnostic-clean. Merges over nvim-lspconfig's shipped lua_ls config.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = { vim.env.VIMRUNTIME } },
    },
  },
})

-- Install + auto-enable the servers. mason-lspconfig v2 defaults
-- automatic_enable = true, which vim.lsp.enable()s each installed server.
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright", -- Python (scripting, exploits)
    "bashls",  -- Bash scripting
    "gopls",   -- Go (many security tools)
    "clangd",  -- C/C++ (binary analysis, exploits)
    "lua_ls",  -- Lua (Neovim config)
  },
})

-- Jump to the prev/next diagnostic and show it in a float. (vim.diagnostic.jump's
-- `float` option was deprecated for `on_jump` and is removed in 0.14, so we open
-- the float from on_jump instead -- same behavior, no deprecation warning.)
local function diagnostic_jump(count)
  return function()
    vim.diagnostic.jump({
      count = count,
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor" })
      end,
    })
  end
end

-- Buffer-local LSP keymaps. Neovim 0.11+ already ships defaults on attach --
-- K (hover), grn (rename), gra (code action), grr (references),
-- gri (implementation), gO (document symbols) -- so we only add extras and the
-- maps this config already used.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, remap = false, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "K", vim.lsp.buf.hover, "Hover docs")
    map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbol")
    map("n", "<leader>vs", function() require("telescope.builtin").lsp_document_symbols() end, "Document symbols (Telescope)")
    map("n", "<leader>vd", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "[d", diagnostic_jump(-1), "Prev diagnostic")
    map("n", "]d", diagnostic_jump(1), "Next diagnostic")
    map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>lr", vim.lsp.buf.references, "References")
    map("n", "<leader>r", vim.lsp.buf.rename, "Rename")
    map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
  end,
})

-- Completion is handled by blink.cmp (see lua/plugins/blink.lua).
