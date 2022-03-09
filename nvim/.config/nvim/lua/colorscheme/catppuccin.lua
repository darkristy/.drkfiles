Drk.utils.plugins.packadd("catppuccin")

local catppuccin = Drk.utils.plugins.require("catppuccin")
catppuccin.setup({
	transparent_background = true,
})

vim.cmd("colorscheme catppuccin")

Drk.settings.lualine_colorscheme = "catppuccin"
