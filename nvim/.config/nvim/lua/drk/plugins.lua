local fn = vim.fn

local function is_enabled(plugin)
	return Drk.plugins[plugin].enabled
end

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = Drk.utils.plugin.require("packer")
packer.init(Drk.plugins.packer.init)

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({
		"lewis6991/impatient.nvim",
		config = "require'config.impatient'",

	})

	-- LSP and Autocomplete
	use({ "williamboman/nvim-lsp-installer" })
	use({ "neovim/nvim-lspconfig" })
	use({
		"jose-elias-alvarez/null-ls.nvim",

	})
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
	use({ "simrat39/rust-tools.nvim" })

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		config = "require'config.cmp'",

	})
	use { "hrsh7th/cmp-buffer" } -- buffer completions
	use { "hrsh7th/cmp-path" } -- path completions
	use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lua" }

	-- snippets
	use { "L3MON4D3/LuaSnip" } --snippet engine
	use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

	use({
		"windwp/nvim-autopairs",
		config = "require'config.autopairs'",
		disable = not is_enabled("autopairs"),

	})

	--Cosmetic
	use({
		"kdheepak/tabline.nvim",
		config = "require'config.tabline'",
		disable = not is_enabled("tabline"),

		requires = {
			{
				"nvim-lualine/lualine.nvim",
				disable = not is_enabled("tabline"),
				config = "require'config.lualine'",

			},
			{ "kyazdani42/nvim-web-devicons" },
		},
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = "require'config.indentline'",

	})

	-- Colorschemes
	use({ "rose-pine/neovim", as = "rose-pine", opt = true })

	-- Version Control
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		disable = not is_enabled("gitsigns"),
		config = "require'config.gitsigns'",

	})

	-- Misc
	use({
		"numToStr/Comment.nvim",
		opt = true,
		keys = { "gc", "gcc" },
		config = "require'config.comment'",

	})
	use({ "RRethy/vim-illuminate" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",

		disable = not is_enabled("telescope"),
		config = "require'config.telescope'",
	})
	use("nvim-telescope/telescope-fzy-native.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		disable = not is_enabled("treesitter"),
		config = "require'config.treesitter'",

	})

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"MunifTanjim/nui.nvim",
		}
	}
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
