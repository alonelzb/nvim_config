local noice = require("noice")
--
noice.setup({
	messages = {
		-- view_history = "popup",
		-- view = "popup",
	},
	--
	views = {
		cmdline_popup = {
			position = {
				row = "50%",
				col = "50%",
			},
			size = {
				min_width = 30,
				width = "auto",
				height = "auto",
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 21,
				col = "50%",
			},
			size = {
				width = 30,
				height = "auto",
				max_height = 15,
			},
			border = {
				style = "rounded",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
			},
		},
		hover = {
			border = {
				style = "rounded",
				padding = { 0, 0 },
			},
			position = { row = 2, col = 2 },
			size = {
				width = "auto",
				height = "auto",
				-- max_height = 20,
				max_width = 60,
			},
		},
	},
	--
	-- 	commands = {
	-- 		history = {
	-- 			view = "popup",
	-- 		},
	-- 	},
	--
	routes = {
		{
			filter = { event = "msg_showmode" },
			view = "notify",
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			-- always route any messages with more than 20 lines to the split view
			filter = { event = "msg_show", min_height = 10 },
			view = "popup",
		},
		{
			-- always route any messages with more than 20 lines to the split view
			filter = { event = "notify", min_height = 10 },
			view = "popup",
		},
		{
			view = "notify",
			filter = { cmdline = "^:" },
		},
	},
})
