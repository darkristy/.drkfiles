local lsp_installer = User.utils.plugin.require("nvim-lsp-installer")
local lspconfig = User.utils.plugin.require("lspconfig")

local opts = {}

lsp_installer.setup()

for server, props in pairs(User.language_servers) do
	opts = {
		on_attach = require("language-servers.handlers").on_attach,
		capabilities = require("language-servers.handlers").capabilities,
	}

	if props.enabled == true then
		local config = props.config
		opts = vim.tbl_deep_extend("force", config, opts)

		lspconfig[server].setup(opts)
	end
end

require("rust-tools").setup({
	tools = {
		inlay_hints = {
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},
	server = opts,
})

require("lspconfig").eslint.setup({
	on_attach = function(client, bufnr)
		local handlers = require("language-servers.handlers")
		handlers.on_attach(client, bufnr)
		vim.api.nvim_command([[autocmd BufWritePre <buffer> EslintFixAll]])
	end,
	capabilities = require("language-servers.handlers").capabilities,
})
