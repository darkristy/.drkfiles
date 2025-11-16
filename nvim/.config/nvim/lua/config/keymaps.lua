local function map(mode, lhs, rhs, opts) vim.keymap.set(mode, lhs, rhs, opts) end

-- TODOqq qqq

local consts = require("consts")
-- map("n", "<leader>e", function()
-- 	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
-- end)

map("n", "<leader>tt", function()
  require("mini.terminal").open() -- open floating terminal
end, { desc = "Open Mini.Terminal (float)" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

--Source file
map("n", "<leader>o", ":update<CR> :source<CR>")

--TAB in general mode will move to text buffer
map("n", "<TAB>", ":bnext<CR>", { silent = true })

--TAB in general mode will move to text buffer
map("n", "<TAB>", ":bnext<CR>", { silent = true })

--TSHIFT-TAB will go back
map("n", "<S-TAB>", ":bprevious<CR>", { silent = true })
--TSHIFT-TAB will go back
map("n", "<S-TAB>", ":bprevious<CR>", { silent = true })
--Escaping on Steriods
map("i", "jk", "<Esc>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })
--Saving
map("n", "<leader>w", ":w<CR>", { silent = true })
--Quit All
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
--Buffer Movement
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map({ "n", "v" }, "<leader>d", [["_d]])

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- prevent x delete from registering when next paste
map("n", "x", '"_x', { silent = true })
map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word cursor is on globally" }
)

map("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

map("n", "K", function()
  local hover_opts = vim.tbl_extend("force", consts.base_float_opts, {
    title = "Hover",
  })
  vim.lsp.buf.hover(hover_opts)
end, { desc = "LSP Hover (styled)" })

-- Signature help
map("i", "<C-h>", function() vim.lsp.buf.signature_help(consts.base_float_opts) end, { desc = "LSP Signature Help" })

map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })

map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
