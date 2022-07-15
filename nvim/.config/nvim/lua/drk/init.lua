Drk = {}

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

Drk.plugins = {
	cmp = { enabled = true },
	tabline = { enabled = true },
	autopairs = { enabled = true },
	gitsigns = { enabled = true },
	telescope = { enabled = true },
	treesitter = {
		enabled = true,
		ensure_installed = {
			"tsx",
			"javascript",
			"lua",
			"rust",
			"toml",
			"jsdoc",
			"markdown",
			"json",
			"yaml",
			"typescript",
			"html",
			"scss",
		},
		indent = { enable = false },
		highlight = { enable = true },
		-- rainbow = { enable = true, extended_mode = false, disable = { "html" } },
	},
	packer = {
		enabled = true,
		-- See vapour/user-config/README.md for an example use of this
		init = {
			enable = true, -- enable profiling via :PackerCompile profile=true
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "single" })
				end,
			},
		},
	},
}

Drk.language_servers = {
	sumneko_lua = { enabled = true },
	tsserver = { enabled = true },
}

Drk.settings = {
	always_force_write = false,
	colorscheme = "rose-pine",
	diagnostics = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	},
}

Drk.utils = require("drk.utils")

require("drk.keybindings")
require("drk.options")
require("drk.plugins")

require("language-servers")
require("colorscheme")

vim.api.nvim_command([[highlight! NormalFloat guibg=none]])
