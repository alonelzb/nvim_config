local lspconfig = require("lspconfig")

local opts = {}
local utils = require('lsp.utils')
local servers = utils.servers
utils.ui()

-- 遍历配置 LSP 服务器
for _, server in pairs(servers) do
	opts = {
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "lsp.servers." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

-- emmet-ls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})
