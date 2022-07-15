local M = {}

M.setup = function()
	local config = Drk.settings.diagnostics

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function ts_utils_init(client, bufnr)
	if client.name == "tsserver" then
		local ts_utils = require("nvim-lsp-ts-utils")

		local ts_utils = Drk.utils.plugin.require("nvim-lsp-ts-utils")
		ts_utils.setup({
			auto_inlay_hints = false,
		})
		ts_utils.setup_client(client)
	end
end

local function lsp_mappings(bufnr, client)
	local opts = { noremap = true, silent = true }
	local function keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "<leader>rn", "<cmd> lua vim.lsp.buf.rename()<CR>", opts)
	keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap("n", "gp", "<cmd>Lspsaga preview_definition<CR>", opts)

	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

	if client.name == "tsserver" then
		-- typescript helpers
		keymap("n", "gs", ":TSLspOrganize<CR>", opts)
		keymap("n", "gr", ":TSLspRenameFile<CR>", opts)
		keymap("n", "gi", ":TSLspImportAll<CR>", opts)
	end
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" or "rust_analyzer" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

	lsp_mappings(bufnr, client)
	ts_utils_init(client, bufnr)

	Drk.utils.plugin.require("illuminate").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = Drk.utils.plugin.require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
