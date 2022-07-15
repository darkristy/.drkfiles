local actions = require("telescope.actions")

local theme = "ivy"

Drk.utils.plugin.require("telescope").setup({
	pickers = {
		find_files = {
			theme = theme,
			find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
		},
		live_grep = {
			theme = theme
		}
	},
	defaults = {
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		file_ignore_patterns = { "node_modules", ".git", ".next", "undo" },
		-- layout_config = { width = 0.75, preview_cutoff = 120 },
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			},
		},
	},
})

require("telescope").load_extension("fzy_native")
