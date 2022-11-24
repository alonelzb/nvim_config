local notify = require("notify")
vim.notify = notify

notify.setup({
	background_colour = "#00000",
	timeout = 2000,
	top_down = false,
	-- render = "simple",
	-- on_open = function(win)
	-- vim.api.nvim_win_close(win)
	-- print(win)
	-- end,
})
