-- brianhuster/live-preview.nvim -- Markdown/HTML preview in a REAL web browser
-- with live reload: the closest analog to VS Code's Ctrl+Shift+V. Because it
-- renders HTML in the browser (markdown-it + GitHub-style CSS), Thai/unicode text
-- and tables display GitHub-style with no terminal font or column-width issues.
-- Pure Lua: no Node/Deno, no yarn, no build step (the reason it's preferred here
-- over the unmaintained markdown-preview.nvim).
--
--   :LivePreview start [file]   open the current (or given) file in the browser
--   :LivePreview close          stop the live-preview server
--   :LivePreview pick           pick a file to preview
--   (mapped to <leader>op / <leader>oc in lua/plugins/init.lua)
--
-- NOTE: this plugin is configured via require('livepreview.config').set(), NOT
-- the usual setup(). The server binds to 127.0.0.1:<port> (localhost only), so it
-- normally needs no firewall exception; just allow it if Windows ever prompts.
-- See :h livepreview for every option.
require("livepreview.config").set({
  port = 5500,         -- change if it clashes with another dev server (e.g. Live Server)
  sync_scroll = true,  -- scroll the browser to follow the cursor while you edit
  dynamic_root = true, -- Serve each file from its OWN directory (webroot = the file's
                       -- dir; URL = just the basename). WITHOUT this, live-preview builds
                       -- the URL as the file path relative to the cwd, and a file that is
                       -- NOT under the cwd makes get_relative_path() return nil -> the URL
                       -- becomes ".../nil" -> 404 Not Found. project.nvim auto-cds the cwd
                       -- to each project root, so any markdown opened outside the current
                       -- root (or on another drive) hit that 404. Trade-off: cross-directory
                       -- relative links/images resolve from the file's own dir (fine for
                       -- single-file markdown preview).
})
