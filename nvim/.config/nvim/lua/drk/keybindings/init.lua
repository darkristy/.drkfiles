local g = vim.g -- a table to access global variables

local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

g.mapleader = " "

map("n", "<Space>", "<NOP>", { silent = true })

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

--Harpoon Binds
map("n", "<leader>hm", "<cmd>:lua require('harpoon.mark').add_file()<cr>", { silent = true })
map("n", "<leader>hp", "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<cr>", { silent = true })


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
map("n", "<Leader>qr", function() require("drk.telescope").reload() end, { silent = true })

--Exit Seeact
map("n", "<nowait><silent> <C-C>", ":noh<CR>")
-- Trouble remaps
map("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, })
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, })
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, })
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, })

--NvimTree Remaps
map("n", "<C-n>", " :NvimTreeToggle<CR>", { silent = true, })
map("n", "<leader>n", " :NvimTreeFindFile<CR>", { silent = true, })
map("n", "<leader>r", " :NvimTreeRefresh<CR>", { silent = true, })


-- Telescope Remaps
local builtin = require("telescope.builtin")

map(
	"n",
	"<leader>ff",
	function() builtin.find_files({ find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" } }) end
)
map("n", "<leader>r", function() builtin.registers() end)
map("n", "<leader>g", function() builtin.live_grep() end)
map("n", "<leader>b", function() builtin.buffers() end)
map("n", "<leader>h", function() builtin.help_tags() end)
map("n", "<leader>f", function() require("telescope").extensions.file_browser.file_browser() end)
map("n", "<leader>s", function() builtin.spell_suggest() end)
map("n", "<leader>i", function() builtin.git_status() end)
