local execute = vim.api.nvim_command
local fn = vim.fn

local function is_enabled(plugin)
	return Drk.plugins[plugin].enabled
end

local function get_cmp()
	if Drk.plugins.cmp.enabled == true then
		return "nvim-cmp"
	else
		return
	end
end

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local packer = Drk.utils.plugins.require("packer")
packer.init(Drk.plugins.packer.init)

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Syntax Highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		disable = not is_enabled("treesitter"),
		config = "require'treesitter-config'",
	})
	use({
		"nvim-treesitter/nvim-tree-docs",
		disable = not is_enabled("treesitter"),
		after = "nvim-treesitter",
	})

	-- LSP and Autocomplete
	use({ "williamboman/nvim-lsp-installer" })
	use({ "neovim/nvim-lspconfig" })
	use({ "jose-elias-alvarez/null-ls.nvim", config = "require'nullls-config'" })
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
	use({ "onsails/lspkind-nvim" })
	use({ "tamago324/nlsp-settings.nvim" })
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp-config")
		end,
		disable = not is_enabled("cmp"),
	})
	use({ "hrsh7th/cmp-nvim-lsp", disable = not is_enabled("cmp") })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp", disable = not is_enabled("cmp") })
	use({ "uga-rosa/cmp-dictionary", disable = not is_enabled("cmp") })
	use({ "hrsh7th/vim-vsnip", disable = not is_enabled("cmp"), after = "nvim-cmp" })
	use({
		"windwp/nvim-autopairs",
		after = get_cmp(),
		config = "require'autopairs-config'",
		disable = not is_enabled("autopairs"),
	})
	use("simrat39/rust-tools.nvim")
	use({ "folke/trouble.nvim", disable = not is_enabled("trouble"), config = "require'trouble-config'" })

	use({ "windwp/nvim-ts-autotag", disable = not is_enabled("treesitter"), after = "nvim-treesitter" })
	use({ "numToStr/Comment.nvim", opt = true, keys = { "gc", "gcc" }, config = "require'comment-config'" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })

	--Cosmetic
	use({
		"kdheepak/tabline.nvim",
		config = "require'tabline-config'",
		disable = not is_enabled("tabline"),
		requires = {
			{
				"nvim-lualine/lualine.nvim",
				disable = not is_enabled("tabline"),
				config = "require'lualine-config'",
			},
			{ "kyazdani42/nvim-web-devicons" },
		},
	})
	use({ "p00f/nvim-ts-rainbow", disable = not is_enabled("treesitter"), after = "nvim-treesitter" })
	use({ "lukas-reineke/indent-blankline.nvim", config = "require'indentline-config'" })

	-- Colorschemes
	use({ "rose-pine/neovim", as = "rose-pine", opt = true })
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Version Control
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" }, disable = not is_enabled("gitsigns"), config = "require'gitsigns-config'" })

	-- Navigation
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		-- cmd = "Telescope",
		disable = not is_enabled("telescope"),
		config = "require'telescope-config'",
	})
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		disable = not is_enabled("nvim_tree"),
		config = "require'nvimtree-config'",
	})

	-- Other
	use({ "folke/which-key.nvim", event = "BufWinEnter", config = "require'which-key-config'" })
	use({
		"akinsho/nvim-toggleterm.lua",
		disable = not is_enabled("toggleterm"),
		config = 'require"toggleterm-config"',
	})


	for _, plugin in pairs(Drk.plugins.user) do
		use(plugin)
	end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
