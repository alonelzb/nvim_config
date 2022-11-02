local fn = vim.fn

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
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({
		{
			"wbthomason/packer.nvim",
		},
		{
			"lewis6991/impatient.nvim",
			-- config = function()
			-- 	require("plugins.impatient")
			-- end,
		},
		"nvim-lua/plenary.nvim",
	})

	use({
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("plugins.comment")
		end,
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		-- after = "nvim-treesitter",
	})
	use({
		"kyazdani42/nvim-web-devicons",
		event = "BufRead",
	})

	use({
		"kyazdani42/nvim-tree.lua",
		-- ft = "alpha",
		cmd = "NvimTreeToggle",
		config = function()
			require("plugins.nvim-tree")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		event = "BufRead",
		config = function()
			require("plugins.bufferline")
		end,
	})
	use({
		"moll/vim-bbye",
		cmd = "Bdelete",
	})
	use({
		"nvim-lualine/lualine.nvim",
		event = "BufRead",
		config = function()
			require("plugins.lualine")
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		event = "BufRead",
		config = function()
			require("plugins.toggleterm")
		end,
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins.project")
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins.indentline")
		end,
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	})

	-- Colorschemes
	use({ "folke/tokyonight.nvim" })
	use({ "olimorris/onedarkpro.nvim" })
	use({ "tanvirtin/monokai.nvim" })
	use({
		"ellisonleao/gruvbox.nvim",
	})
	use({
		"Mofiqul/dracula.nvim",
		-- opt = true,
	})
	use({ "rebelot/kanagawa.nvim" })
	use({ "marko-cerovac/material.nvim" })
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require("plugins.cmp")
		end,
	}) -- The completion plugin
	use({ "hrsh7th/cmp-nvim-lsp" })
	-- use { "hrsh7th/cmp-nvim-lsp", event = 'BufRead' }
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- buffer completions
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- path completions
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }) -- snippet completions

	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins.autopairs")
		end,
	})
	-- snippets
	use({ "L3MON4D3/LuaSnip", after = "nvim-cmp" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", event = "BufRead" }) -- a bunch of snippets to use

	-- LSP
	use({
		{
			"williamboman/mason.nvim",
			-- cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
			config = function()
				require("lsp._mason")
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			--after = 'mason',
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = require("lsp.utils").servers,
					automatic_installation = true,
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			-- after = "mason-lspconfig",
			config = function()
				require("lsp.lspconfig")
			end,
		},
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-cmp",
		config = function()
			require("plugins.null-ls")
		end,
	})
	-- for formatters and linters
	-- use({
	-- 	"RRethy/vim-illuminate",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("plugins.illumiate")
	-- 	end,
	-- })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugins.telescope")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		--cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
		-- event = "InsertEnter",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		cmd = "BufRead",
	})

	-- 快速移动,esaymotion
	use({
		"phaazon/hop.nvim",
		event = "BufRead",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- UI 增强
	use({
		"onsails/lspkind-nvim",
		event = "BufRead",
	})
	use({
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			-- require('plugins.lspsaga')
			require("lspsaga").init_lsp_saga({})
		end,
	})
	use({
		"rcarriga/nvim-notify",
		event = "BufRead",
		config = function()
			require("plugins.nvim-notify")
		end,
	})

	-- other
	use({
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	})

	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
