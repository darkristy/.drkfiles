local null_ls = Drk.utils.plugins.require("null-ls")
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
		b.formatting.stylua,
		b.formatting.black.with({ extra_args = { "--fast" } }),
		b.formatting.rustfmt,
		-- b.formatting.deno_fmt,
	},
})

-- local refactoring = {
-- 	name = "refactoring",
-- 	method = null_ls.methods.CODE_ACTION,
-- 	filetypes = { "go", "javascript", "lua", "python", "typescript", "typescriptreact" },
-- 	generator = {
-- 		-- the plugin currently returns all refactors, regardless of context / availability
-- 		-- so we ignore params
-- 		fn = function(_)
-- 			local ok, refactors = pcall(require("refactoring").get_refactors)
-- 			if not ok then
-- 				return
-- 			end
--
-- 			local actions = {}
-- 			for _, name in ipairs(refactors) do
-- 				table.insert(actions, {
-- 					title = name,
-- 					action = function()
-- 						require("refactoring").refactor(name)
-- 					end,
-- 				})
-- 			end
-- 			return actions
-- 		end,
-- 	},
-- }
--
-- null_ls.register(refactoring)
-- null_ls.get_sources()
