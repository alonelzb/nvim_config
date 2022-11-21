local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "absolute" },
		-- path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
		dynamic_preview_title = true,
		wrap_results = true,

		layout_config = {
			horizontal = {
				height = 0.9,
				preview_cutoff = 120,
				prompt_position = "bottom",
				width = 0.8,
				preview_width = 0.6,
			},
		},

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})
