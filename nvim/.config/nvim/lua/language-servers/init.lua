local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local opts = {}

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	return
end

local language_servers = {}

for server, props in pairs(Drk.language_servers) do
	if props.enabled == true then
		table.insert(language_servers, server)
	end
end

lsp_installer.setup({
	ensure_installed = language_servers,
})

for _, server in pairs(language_servers) do
	opts.on_attach = require("language-servers.handlers").on_attach
	opts.capabilities = require("language-servers.handlers").capabilities

	local config = require("language-servers.providers." .. server)
	opts = vim.tbl_deep_extend("force", config, opts)

	lspconfig[server].setup(opts)
end

require("lspconfig").eslint.setup({
	on_attach = function(client, bufnr)
		opts.on_attach(client, bufnr)
		vim.api.nvim_command([[autocmd BufWritePre <buffer> EslintFixAll]])
	end,
	capabilities = opts.capabilities,
})

require("language-servers.providers.null-ls")
require("language-servers.handlers").setup()
