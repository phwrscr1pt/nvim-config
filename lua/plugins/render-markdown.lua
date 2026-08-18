-- MeanderingProgrammer/render-markdown.nvim -- in-buffer Markdown rendering.
-- It decorates the SAME editable buffer (conceals ####/*/` markers and draws
-- heading styles, code-block backgrounds, bullets and table borders) -- an
-- in-editor quick-look, NOT a separate rendered pane like VS Code. It reuses the
-- treesitter markdown parsers and nvim-web-devicons already in this config, so
-- there is no new build step or runtime dependency.
--
-- Thai note: by default the plugin pads each table cell to a computed visual
-- width (cell = 'padded'/'trimmed'), and Thai combining vowels/tone marks (Unicode
-- nonspacing marks, category Mn) get miscounted -- so mixed Thai+ASCII columns
-- drift. `cell = 'raw'` replaces only the '|' border characters and leaves cell
-- contents UNMODIFIED, so the plugin never re-pads/re-aligns columns and Thai
-- tables can't be shifted by its width math (trade-off: columns stay only as
-- aligned as they already are in the source). Non-table Thai (prose/headings/code)
-- renders fine regardless. Use pipe_table = { enabled = false } to drop table
-- styling entirely.
require("render-markdown").setup({
  pipe_table = { cell = "raw" },
})
