local g = vim.g -- a table to access global variables

local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

local opts = { silent = true }

g.mapleader = " "

map("n", "<Space>", "<NOP>", { silent = true })

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { silent = true })

--Better Text Movement
map("n", "<leader>k", ":m .-2<cr>==")
map("n", "<leader>j", ":m .+1<cr>==")
map("i", "<C-K>", "<esc>:m .-2<cr>==")
map("i", "<C-J>", "<esc>:m .+1<cr>==")
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Better Window Movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

--Better Edits
map("n", "Y", "y$", {})

map("t", "<esc>", [[<C-\><C-n>]])
map("t", "jk", [[<C-\><C-n>]])
map("t", "<C-h>", [[<C-\><C-n><C-W>h]])
map("t", "<C-j>", [[<C-\><C-n><C-W>j]])
map("t", "<C-k>", [[<C-\><C-n><C-W>k]])
map("t", "<C-l>", [[<C-\><C-n><C-W>l]])

--Escaping on Steriods
map("i", "jk", "<Esc>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })

--Saving
map("n", "<leader>ws", ":w<CR>", { silent = true })

--TAB in general mode will move to text buffer
map("n", "<TAB>", ":bnext<CR>", { silent = true })

--TSHIFT-TAB will go back
map("n", "<S-TAB>", ":bprevious<CR>", { silent = true })

--Alternative Quiting
map("n", "<leader>wq", ":bd<CR>", { silent = true })

--Quiting
map("n", "<C-c>", "<Esc>", { silent = true })
map("n", "<Leader>qr", function()
	require("drk.telescope").reload()
end, { silent = true })

--Exit Seeact
map("n", "<nowait><silent> <C-C>", ":noh<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fp", ":Telescope projects<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
