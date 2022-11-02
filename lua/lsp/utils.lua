local M = {}

M.servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"volar",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
}

function M.ui()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end
	vim.diagnostic.config({
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always", -- 显示诊断源
			header = "",
			prefix = "",
		},
	})
end

-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(client)
--             -- apply whatever logic you want (in this example, we'll only use null-ls)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--     })
-- end
-- local function format_onsave(client, bufnr)
--     -- if you want to set up formatting on save, you can use this as a callback
--     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--     -- add to your shared on_attach callback
--     if client.supports_method("textDocument/formatting") then
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup,
--             buffer = bufnr,
--             callback = function()
--                 lsp_formatting(bufnr)
--             end,
--         })
--     end
-- end
--
-- 高亮光标下的背景
local function hi_undercursor(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
          hi! link LspReferenceRead Visual
          hi! link LspReferenceText Visual
          hi! link LspReferenceWrite Visual
        ]])
		-- vim.cmd [[
		--   hi! LspReferenceRead cterm=bold ctermbg=red guibg=#483d8b
		--   hi! LspReferenceText cterm=bold ctermbg=red guibg=#483d8b
		--   hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#483d8b
		-- ]]
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	-- local keymap = vim.keymap.set
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
	-- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>Lspsaga implement<CR>", opts)
	-- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	-- keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	-- keymap(bufnr, "n", "g]", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	-- keymap(bufnr, "n", "g[", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	keymap(bufnr, "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	-- keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	-- keymap(bufnr, "n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>sh", "<cmd>Lspsaga signature_help<CR>", opts)
	keymap(bufnr, "n", "<leader>ds", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	keymap(bufnr, "n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap(bufnr, "n", "<leader>sd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap(bufnr, "n", "<leader>ol", "<cmd>LSoutlineToggle<CR>", opts)
end

function M.on_attach(client, bufnr)
	--  自动显示诊断信息
	-- vim.api.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		require("lspsaga.diagnostic").show_line_diagnostics()
	-- 	end,
	-- })

	-- vim.api.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		local opts = {
	-- 			focusable = false,
	-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	-- 			border = "rounded",
	-- 			source = "always",
	-- 			prefix = "",
	-- 			-- scope = '',
	-- 			scope = "cursor",
	-- 		}
	-- 		vim.diagnostic.open_float(nil, opts)
	-- 	end,
	-- })
	-- 禁用格式化功能，交给专门插件null-ls处理
	-- client.resolved_capabilities.document_formatting = false
	-- client.resolved_capabilities.document_range_formatting = false
	-- if client.name == 'tsserver' then
	--     client.server_capabilities.documentFormattingProvider = false
	-- end

	lsp_keymaps(bufnr)
	hi_undercursor(client, bufnr)
	-- format_onsave(client, bufnr)
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
