local g = vim.g -- a table to access global variables

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "

map("n", "<Space>", "<NOP>", { noremap = true, silent = true })

--LSPSaga
-- map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<cr>", { silent = true, noremap = true })
-- map(
-- 	"v",
-- 	"<leader>ca",
-- 	"<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>",
-- 	{ silent = true, noremap = true }
-- )
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<cr>", { silent = true, noremap = true })

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
map("n", "Y", "y$", { noremap = true })

--Harpoon Binds
map("n", "<leader>hm", "<cmd>:lua require('harpoon.mark').add_file()<cr>", { silent = true, noremap = true })
map("n", "<leader>hp", "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<cr>", { silent = true, noremap = true })

local opts = { noremap = true }
map("t", "<esc>", [[<C-\><C-n>]], opts)
map("t", "jk", [[<C-\><C-n>]], opts)
map("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
map("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)

--Escaping on Steriods
map("i", "jk", "<Esc>", { noremap = true, silent = true })
map("i", "kj", "<Esc>", { noremap = true, silent = true })

--Saving
map("n", "<leader>ws", ":w<CR>", { noremap = true, silent = true })

--TAB in general mode will move to text buffer
map("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })

--TSHIFT-TAB will go back
map("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

--Alternative Quiting
map("n", "<leader>wq", ":bd<CR>", { noremap = true, silent = true })

--Quiting
map("n", "<C-c>", "<Esc>", { noremap = true, silent = true })
map("n", "<Leader>qr", '<cmd>:lua require("drk.telescope").reload()<CR>', { noremap = true, silent = true })

--Exit Seeact
map("n", "<nowait><silent> <C-C>", ":noh<CR>")
-- Trouble remaps
map("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

--NvimTree Remaps
map("n", "<C-n>", " :NvimTreeToggle<CR>", { silent = true, noremap = true })
map("n", "<leader>n", " :NvimTreeFindFile<CR>", { silent = true, noremap = true })
map("n", "<leader>r", " :NvimTreeRefresh<CR>", { silent = true, noremap = true })

map("n", "<leader>gr", "<cmd>lua require('lspsaga.rename').rename()<CR>", { silent = true, noremap = true })

-- Telescope Remaps
map(
	"n",
	"<leader>ff",
	'<cmd>lua require("telescope.builtin").find_files({find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" }})<cr>'
)
map("n", "<leader>r", '<cmd>lua require("telescope.builtin").registers()<cr>')
map("n", "<leader>g", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map("n", "<leader>b", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map("n", "<leader>h", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map("n", "<leader>f", '<cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>')
map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')
map("n", "<leader>i", '<cmd>lua require("telescope.builtin").git_status()<cr>')
