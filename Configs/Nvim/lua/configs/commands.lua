local function get_files_from_pattern(pattern)
	-- resolve pattern to existing files
	local files = vim.fn.glob(pattern, false, true)

	-- if no files are found, the pattern is just file name
	if #files == 0 then
		return { pattern }
	end

	return files
end

local function create_new_tab(file_names)
	for _, file_name in ipairs(file_names) do
		vim.cmd("tabnew " .. vim.fn.fnameescape(file_name))
	end
end

-- shortcut for tabnew which also allows multiple files at once
vim.api.nvim_create_user_command("Tn", function(opts)
	for _, pattern in ipairs(opts.fargs) do
		create_new_tab(get_files_from_pattern(pattern))
	end
end, {
	nargs = "+",
	complete = "file",
})
