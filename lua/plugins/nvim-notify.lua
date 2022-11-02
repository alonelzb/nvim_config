-- require('notify').setup({
--     background_colour = "Normal",
--     timeout = 2000
--
-- })

local notify = require("notify")

notify.setup({
	background_colour = "#0000ff",
	timeout = 100,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	pattern = { "*.js", "*.ts", "*.vue" },
-- 	callback = function()
-- 		notify("saved")
-- 	end,
-- })
