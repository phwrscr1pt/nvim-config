-- lazy.nvim plugin specs with full lazy-loading.
-- At startup only the colorscheme loads; everything else loads on demand
-- (a keypress, a command, an event, or a filetype). Per-plugin config still
-- lives in its own lua/plugins/<name>.lua file.
return {
  -- Colorscheme — the ONLY plugin loaded eagerly at startup.
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme onedark]])
    end,
  },

  -- Icons — loaded on demand by the tree / statusline that depend on it.
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function() require("plugins.devicons") end,
  },

  -- Statusline — loads right after startup (VeryLazy), so it doesn't block it.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugins.lualine") end,
  },

  -- File explorer — loads on <leader>e or any NvimTree* command.
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus", "NvimTreeOpen" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "File tree" },
    },
    config = function() require("plugins.nvim-tree") end,
  },

  -- Quick file navigation — loads on its keys or :Grapple.
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple tag/untag" },
      { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple menu" },
    },
    config = function() require("plugins.grapple") end,
  },

  -- Fuzzy finder — loads on its keys or :Telescope (keymaps live here now).
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>f", function()
        -- git_files inside a git repo, else find_files. Launching nvim outside a
        -- repo (e.g. from your home dir) otherwise throws telescope's
        -- "not a git directory" error.
        local builtin = require("telescope.builtin")
        if vim.fs.root(vim.fn.getcwd(), ".git") then
          builtin.git_files()
        else
          builtin.find_files()
        end
      end, desc = "Find files (git-aware)" },
      { "<C-p>",      "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ps", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
    },
  },

  -- Git UI — loads on :LazyGit (<leader>gg is defined in core/keymaps.lua).
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "LazyGit",
  },

  -- Terminal — loads on its Alt keys or :ToggleTerm.
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<A-w>", "<cmd>ToggleTerm direction=horizontal<cr>", mode = { "n", "t" }, desc = "Terminal (horizontal)" },
      { "<A-q>", "<cmd>ToggleTerm direction=float<cr>",      mode = { "n", "t" }, desc = "Terminal (float)" },
      -- Alias for <A-q>. NORMAL MODE ONLY, deliberately.
      -- A `t`-mode <C-\> would shadow <C-\><C-n>, the only way out of
      -- terminal mode, and this config defines no other terminal escape --
      -- lazygit, claudecode (provider = "native") and plain :terminal would
      -- all trap you. Matters on macOS: <A-*> keys do not fire while the
      -- Thai input source is active, so this is the way in while typing Thai.
      { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", mode = "n", desc = "Terminal (float)" },
    },
    config = function() require("plugins.toggleterm") end,
  },

  -- LSP & completion (native vim.lsp on Neovim 0.11+; lsp-zero removed).
  -- Loads when you open a file to edit.
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function() require("plugins.lsp") end,
  },

  -- Completion — blink.cmp (replaces nvim-cmp). Built-in LSP/path/snippet/buffer
  -- sources + fuzzy matcher, native vim.snippet. Pinned to 1.* so lazy fetches a
  -- prebuilt matcher binary (no Rust toolchain needed on Windows). Loaded as an
  -- nvim-lspconfig dependency so capabilities are ready when servers enable.
  {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = true, -- loaded on demand as an nvim-lspconfig dependency, not at startup
    config = function() require("plugins.blink") end,
  },

  -- Practice game — loads on :VimBeGood.
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },

  -- Keymap discovery — press <leader> (or any prefix) and pause to see a menu
  -- of the available mappings with their descriptions. Great while learning.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() require("plugins.whichkey") end,
  },

  -- Git gutter signs + in-buffer hunk staging/preview/blame (complements lazygit).
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require("plugins.gitsigns") end,
  },

  -- Auto-close brackets/quotes while typing (minimal, from the mini.nvim family).
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    config = function() require("mini.pairs").setup() end,
  },

  -- Label-jump motion — press `s` then the target chars, then a one-key label to teleport
  -- anywhere on screen; also enhances f/F/t/T to work across lines.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Add/change/delete surrounding pairs & HTML tags. Moved to a `gs` prefix
  -- (gsa/gsd/gsr/...) because flash.nvim owns `s`. e.g. select a word then
  -- `gsa"` wraps it in quotes, `gsd"` removes them, `gsr"'` changes " to '.
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "gsa", delete = "gsd", replace = "gsr",
          find = "gsf", find_left = "gsF", highlight = "gsh",
        },
      })
    end,
  },

  -- Tree-sitter: real syntax highlighting + indentation. The `main` branch is
  -- the Neovim 0.12 implementation; it compiles parsers locally (needs the
  -- tree-sitter CLI + a C compiler), so it must load eagerly (not lazily).
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function() require("plugins.treesitter") end,
  },

  -- Recent-projects picker + auto-cd to a project's root. Maintained fork of
  -- ahmedkhalf/project.nvim (the original is unmaintained and errors on 0.12:
  -- it calls the removed vim.lsp.buf_get_clients).
  {
    "DrKJeff16/project.nvim",
    lazy = false, -- load early so it detects the root of files opened at startup
    config = function() require("plugins.project") end,
  },

  -- Claude Code integration — connects Neovim to the `claude` CLI over the SAME
  -- IDE WebSocket protocol as the official VS Code extension: selection context,
  -- inline diffs, accept/reject. Requires the `claude` CLI on PATH. Loads on the
  -- <leader>a* keys / :ClaudeCode* commands.
  {
    "coder/claudecode.nvim",
    cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code (toggle/focus)" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "x", desc = "Claude: send selection" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: reject diff" },
    },
    config = function() require("plugins.claudecode") end,
  },

  -- Markdown preview in a REAL browser (like VS Code's Ctrl+Shift+V) -- renders
  -- HTML with live reload, so Thai/unicode and tables render GitHub-style in the
  -- browser. Pure Lua: no Node/Deno/build step. Loads on <leader>o* or :LivePreview.
  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    ft = { "markdown", "html" },
    keys = {
      { "<leader>op", "<cmd>LivePreview start<cr>", desc = "Markdown preview (browser)" },
      { "<leader>oc", "<cmd>LivePreview close<cr>", desc = "Markdown preview stop" },
    },
    config = function() require("plugins.live-preview") end,
  },

  -- In-buffer Markdown rendering (in-editor quick-look, not a separate pane).
  -- Reuses the treesitter markdown parsers + nvim-web-devicons already in this
  -- config, so no new build/deps. Loads on the markdown filetype or <leader>or.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    keys = {
      { "<leader>or", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle in-buffer markdown render" },
    },
    config = function() require("plugins.render-markdown") end,
  },
}
