Drk.utils.plugin.require("nvim-autopairs").setup({
	check_ts = true, -- treesitter integration
	disable_filetype = { "TelescopePrompt" },
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"

Drk.utils.plugin.require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done {})
