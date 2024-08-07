-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end
--Escaping on Steriods
map("i", "jk", "<Esc>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })

--Saving
map("n", "<leader>w", ":w<CR>", { silent = true })

map("n", "ss", ":split<Return>", { silent = true })
map("n", "sv", ":vsplit<Return>", { silent = true })
