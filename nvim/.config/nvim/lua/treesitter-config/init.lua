-- Drk.utils.plugins.packadd("nvim-treesitter")

Drk.utils.plugins.require("nvim-treesitter.configs").setup({
	ensure_installed = Drk.plugins.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	indent = Drk.plugins.treesitter.indent,
	highlight = Drk.plugins.treesitter.highlight,
	autotag = Drk.plugins.treesitter.autotag,
	rainbow = Drk.plugins.treesitter.rainbow,
	tree_docs = { enable = true },
	context_commentstring = {
		enable = true,
		config = {
			typescript = { __default = "// %s", __multiline = "/* %s */" },
		},
	},
})

local parser_config =  Drk.utils.plugins.require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
