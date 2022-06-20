local M = {}

M.setup = function()
	local config = User.settings.diagnostics

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_mappings(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

	keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
	keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
	keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)

	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	keymap(
		bufnr,
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	keymap(
		bufnr,
		"n",
		"gl",
		'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
		opts
	)
	keymap(
		bufnr,
		"n",
		"<leader>so",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		opts
	)
	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
end

local ts_utils = function(bufnr, client)
	local ts_utils = User.utils.plugin.require("nvim-lsp-ts-utils")
	ts_utils.setup({
		auto_inlay_hints = false,
	})
	ts_utils.setup_client(client)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" or "rust_analyzer" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	lsp_mappings(bufnr)
	ts_utils(bufnr, client)

	User.utils.plugin.require("illuminate").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = User.utils.plugin.require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
