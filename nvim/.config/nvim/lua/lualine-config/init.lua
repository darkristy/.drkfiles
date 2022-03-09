local function getWords()
	if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
		return tostring(vim.fn.wordcount().words)
	end
end


local tabline = Drk.utils.plugins.require("tabline")

Drk.utils.plugins.require("lualine").setup({
	options = {
		theme = Drk.settings.lualine_colorscheme,
		section_separators = { left = "", right = "" },
		component_separators = { left = " ", right = " " },
	},
  sections = {
    lualine_a = { "mode", "paste" },
   	lualine_b = {
			{ "branch", icon = "" },
			{
				"diff",
				color_added = "#a7c080",
				color_modified = "#ffdf1b",
				color_removed = "#ff6666",
		}},
   	lualine_c = {
			{ "diagnostics", sources = { "nvim_diagnostic" } },
			function()
				return "%="
			end,
			"filename",
			{ getWords },
		},
    lualine_x = { 'filetype'},
    lualine_y = {{'progress'}},
    lualine_z = {{"location", icon = "" }},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },

	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			tabline.tabline_buffers,
		 },
			lualine_x = {
				tabline.tabline_tabs,
			 },
			lualine_y = {},
			 lualine_z = {},
		},
		extensions = { "nvim-tree", "toggleterm" },

})


