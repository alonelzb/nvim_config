-- require("nvim-treesitter")
local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = {
		"lua",
		"markdown",
		"markdown_inline",
		"bash",
		"python",
		"html",
		"css",
		"javascript",
		"typescript",
		"vue",
		"regex",
		"vim",
	}, -- put the language you want in this array
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python" } },

	-- 上下文注释
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	-- 彩虹括号
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {
			"#ff79c6",
			"#ee6985",
			"#D6A760",
			"#7794f4",
			"#b38bf5",
			"#7cc7fe",
		}, -- table of hex strings
		termcolors = {}, -- table of colour name strings
	},
})
