-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override LazyVim defaults
vim.keymap.del("n", "<leader>gG")

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<tab>", ":bnext<cr>", opts)
map("n", "<s-tab>", ":bprev<cr>", opts)

-- Move caret to the last non-whitespace character in the line
map("i", "<c-e>", "<c-o>A")
