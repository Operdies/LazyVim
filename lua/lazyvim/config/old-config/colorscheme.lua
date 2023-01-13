vim.g.transparent_enabled = true
vim.g.tokyonight_transparent = vim.g.transparent_enabled
local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

-- enable transparency for themes without support (which tokyonight does)
-- require("transparent").setup({
--   enable = true, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     -- example of akinsho/nvim-bufferline.lua
--     "BufferLineTabClose",
--     "BufferlineBufferSelected",
--     "BufferLineFill",
--     "BufferLineBackground",
--     "BufferLineSeparator",
--     "BufferLineIndicatorSelected",
--   },
--   exclude = {
--     "LinrNr",
--     "SignColumnn",
--     "CursorLineNr"
--   }, -- table: groups you don't want to clear
-- })
--
