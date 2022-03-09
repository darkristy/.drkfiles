require("drk.globals")

Drk = {}

Drk = {
	options = { tabwidth = 2 },
	language_servers = {
		sumneko_lua = { enabled = true, config = require("language-servers.config.sumneko_lua") },
		cssls = { enabled = true, config = require("language-servers.config.cssls") },
		-- jsonls = { enabled = true, config = require("language-servers.config.jsonls") },
		rust_analyzer = { enabled = true, config = require("language-servers.config.rust_analyzer") },
		tailwindcss = { enabled = true, config = {} },
	},
	plugins = {
		autopairs = { enabled = true },
		gitsigns = { enabled = true },
		nvim_tree = { enabled = true },
		tabline = { enabled = true },
		vsnip = { enabled = true },
		telescope = { enabled = true },
		trouble = { enabled = true },
		toggleterm = { enabled = true },
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
			autotag = { enable = true },
			rainbow = { enable = true, extended_mode = false, disable = { "html" } },
		},
		cmp = {
			enabled = true,
			sources = {
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "buffer" },
				{ name = "omni" },
				{ name = "dictionary" },
			},
		},
		-- Packer-specific needs
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

		-- User-loaded plugins
		user = {},
	},
	utils = {},
	settings = {
		always_force_write = false,
		colorscheme = "rose-pine",
		lualine_colorscheme = "rose-pine",
		diagnostics = {
			-- disable virtual text
			virtual_text = false,
			-- show signs
			signs = { active = signs },
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	},
}

require("drk.utils")
