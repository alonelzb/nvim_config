local noice = require("noice")
--
noice.setup({
	-- 	-- add any options here
	-- 	-- presets = {
	-- 	-- 	command_palette = true, -- position the cmdline and popupmenu together
	-- 	-- },
	-- 	messages = {
	-- 		-- view_history = "popup",
	-- 		-- view = "popup",
	-- 	},
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
	},
})
