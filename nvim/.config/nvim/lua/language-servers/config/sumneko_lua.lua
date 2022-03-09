return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Get the language server to recognize the `vim` global
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}
