User.utils.plugin.packadd("rose-pine")

User.utils.plugin.require("rose-pine").setup({
	disable_background = true,
})

vim.cmd("colorscheme rose-pine")
User.settings.lualine_colorscheme = "rose-pine"
