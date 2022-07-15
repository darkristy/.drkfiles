local null_ls = Drk.utils.plugin.require("null-ls")
local b = null_ls.builtins

null_ls.setup({
	sources = {
		b.formatting.stylua,
		b.formatting.shfmt,
		b.diagnostics.shellcheck,
		b.diagnostics.eslint.with({ -- eslint or eslint_d
			prefer_local = "node_modules/.bin",
		}),
		b.code_actions.eslint.with({ -- eslint or eslint_d
			prefer_local = "node_modules/.bin",
		}),
		b.formatting.prettier.with({ -- prettier, eslint, eslint_d, or prettierd
			prefer_local = "node_modules/.bin",
			filetypes = { "html", "yaml", "md", "mdx", "json", "scss" },
		}),
		b.formatting.black.with({ extra_args = { "--fast" } }),
		b.formatting.rustfmt,
		-- b.formatting.deno_fmt,
	},
})
