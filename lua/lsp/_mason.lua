local servers = require('lsp.utils').servers

local settings = {
    border = "rounded",
     ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

require("mason").setup(settings)
