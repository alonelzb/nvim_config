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
            cmd = { 'PackerSync', 'PackerStatus', 'PackerCompile' },
            config = function()
                require('plugins.packer_init')
            end
        },
        {
            "lewis6991/impatient.nvim",
            opt = true
            -- config = function()
            -- 	require("plugins.impatient")
            -- end,
        },
        "nvim-lua/plenary.nvim",
    })

    use({
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            require('plugins.nvim_tree')
        end
    })

    use({
        "numToStr/Comment.nvim",
        -- module = "Comment",
        -- event = "BufRead",
        -- keys = { '<C-_>', 'gc', '<C-/>' },
        config = function()
            require('plugins.comment')
        end
    })
    use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- after = "Comment",
    })

    use({
        "kyazdani42/nvim-web-devicons",
        -- event = "BufRead",
    })

    use({
        "akinsho/bufferline.nvim",
        event = "BufRead",
        config = function()
            require('plugins.bufferline')
        end
    })
    use({
        "moll/vim-bbye",
        cmd = "Bdelete",
    })
    use({
        "nvim-lualine/lualine.nvim",
        event = "BufRead",
        config = function()
            require('plugins.lualine')
        end
    })
    use({
        "akinsho/toggleterm.nvim",
        event = "BufRead",
        config = function()
            require('plugins.toggleterm')
        end
    })
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require('plugins.project')
        end
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require('plugins.indentline')
        end
    })
    use({
        "goolord/alpha-nvim",
        config = function()
            require('plugins.alpha')
        end
    })

    -- Colorschemes
    use({ "glepnir/zephyr-nvim" })
    use({ "folke/tokyonight.nvim", disable = true })
    use({ "olimorris/onedarkpro.nvim", disable = true })
    use({ "tanvirtin/monokai.nvim", disable = true })
    use({ "ellisonleao/gruvbox.nvim", disable = true })
    use({ "Mofiqul/dracula.nvim", disable = true, cmd = 'color dracula' })
    use({ "rebelot/kanagawa.nvim", disable = true })
    use({ "marko-cerovac/material.nvim", disable = true })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        opt = true
    })

    -- cmp plugins
    use({
        "hrsh7th/nvim-cmp",
        after = "friendly-snippets",
        -- event = 'InsertEnter',
        config = function()
            require('plugins.nvim_cmp')
        end
    }) -- The completion plugin
    -- use({ "hrsh7th/cmp-nvim-lsp", event = 'BufRead' })
    use { "hrsh7th/cmp-nvim-lsp", event = 'BufRead' }
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- buffer completions
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- path completions
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    -- use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }) -- snippet completions
    use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions

    -- snippets
    use({
        "L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            -- relative to the directory of $MYVIMRC
            require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
        end
    })

    --snippet engine
    use({ "rafamadriz/friendly-snippets", module = { 'cmp', 'cmp_nvim_lsp' }, event = 'InsertEnter' }) -- a bunch of snippets to use

    -- 括号匹配
    use({
        "windwp/nvim-autopairs",
        -- event = "InsertEnter",
        after = 'nvim-cmp',
        config = function()
            require('plugins.autopairs')
        end
    })

    -- LSP
    use({
        {
            "williamboman/mason.nvim",
            -- cmd = {'Mason', 'MasonInstall'},
            -- event = "BufRead",
            -- cmd = {'Mason', 'MasonInstall'},
            config = function()
                require('mason').setup()
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            -- after = 'mason',
            -- event = "BufRead",
            -- cmd = {'Mason', 'MasonInstall'},
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
            -- event = 'BufRead',
            -- cmd = {'Mason', 'MasonInstall'},
            config = function()
                require("lsp.lspconfig")
            end,
        },
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-cmp",
        config = function()
            require('plugins.null_ls')
        end
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
            require('plugins.telescope')
        end
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        -- cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
        event = "BufRead",
        config = function()
            require('plugins.treesitter')
        end
    })
    use({
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
    })

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
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
    -- use({
    -- 	"ggandor/leap.nvim",
    -- 	event = "BufRead",
    -- 	config = function()
    -- 		require("leap").add_default_mappings()
    -- 		-- you can configure Hop the way you like here; see :h hop-config
    -- 	end,
    -- })

    -- UI 增强
    use({
        "onsails/lspkind-nvim",
        event = "BufRead",
    })
    use({
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        config = function()
            require('plugins.lspsaga')
        end
    })

    use({
    	"folke/noice.nvim",
    	event = "BufRead",
    	config = function()
    		require("plugins.noice")
    	end,
    	requires = {
    -- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    		{ "MunifTanjim/nui.nvim" },
    	},
    })

    use({
        "rcarriga/nvim-notify",
        event = "BufRead",
        config = function()
            require('plugins.nvim_notify')
        end
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
    -- 函数签名
    use({
        "ray-x/lsp_signature.nvim",
        -- event = "InsertEnter",
        opt = true,
        config = function()
            require("plugins.lsp_signature")
        end,
    })

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "BufRead",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
