local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
	vim.notify("formatting done")
end

-- -- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettierd,
		-- formatting.prettierd.with({
		--     extra_filetypes = { "toml" },
		--     extra_args = {
		--         "--no-semi",
		--         "--single-quote",
		--         "--jsx-single-quote",
		--         "--arrow-parens avoid",
		--         "--vue-indent-script-and-style",
		--     },
		-- extra_args = { "--config-path", vim.fn.expand("~/.prettierrc.json") },
		-- env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"), },
		-- }),
		formatting.stylua,
		-- formatting.yapf.with({
		-- 	extra_args = {
		-- 		"--style {based_on_style: pep8, indent_width: 2}",
		-- 	},
		-- }),
		formatting.black,
		-- diagnostics.eslint_d,
		-- formatting.google_java_format,
		-- diagnostics.flake8,
	},
	on_attach = on_attach,
})
vim.keymap.set("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { silent = true })
