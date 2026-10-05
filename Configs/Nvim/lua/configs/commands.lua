-- shortcut for tabnew which also allows multiple files at once
vim.api.nvim_create_user_command("Tn", function(opts)
	for _, pattern in ipairs(opts.fargs) do
		local files = vim.fn.glob(pattern, false, true)
		for _, file_name in ipairs(files) do
			vim.cmd("tabnew " .. vim.fn.fnameescape(file_name))
		end
	end
end, {
	nargs = "+",
	complete = "file",
})
