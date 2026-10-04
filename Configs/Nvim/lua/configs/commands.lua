-- shortcut for tabnew which also allows multiple files at once
vim.api.nvim_create_user_command("Tn", function(opts)
	for _, file_name in ipairs(opts.fargs) do
		vim.cmd("tabnew " .. vim.fn.fnameescape(file_name))
	end
end, {
	nargs = "+",
	complete = "file",
})
