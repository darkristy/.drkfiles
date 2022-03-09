local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

Drk.utils.plugins.require("nvim-lsp_installer")
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local handlers = require("language-servers.handlers")

	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end

	for ls_type, props in pairs(Drk.language_servers) do
		if server.name == "tsserver" then
			local serverOpts = {
				init_options = require("nvim-lsp-ts-utils").init_options,
			}

			opts = vim.tbl_deep_extend("force", serverOpts, opts)
		end
		if props.enabled == true and server.name == ls_type then
			local config = props.config
			opts = vim.tbl_deep_extend("force", config, opts)
		end
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	require("rust-tools").setup({
		tools = {
			inlay_hints = {
				parameter_hints_prefix = "",
				other_hints_prefix = "",
			},
		},
		server = opts,
	})
	server:setup(opts)
end)

require("lspconfig").eslint.setup({

	on_attach = function(client, bufnr)
		local handlers = require("language-servers.handlers")
		handlers.on_attach(client, bufnr)
		vim.api.nvim_command([[autocmd BufWritePre <buffer> EslintFixAll]])
	end,
	capabilities = require("language-servers.handlers").capabilities,
})

