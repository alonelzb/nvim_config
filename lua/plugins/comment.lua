local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

print("load comment")
