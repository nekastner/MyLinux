local function get_absolute_file_paths_from_pattern(pattern)
	local relative_file_paths = vim.fn.glob(pattern, false, true)

	if #relative_file_paths == 0 then
		relative_file_paths = { pattern }
	end

	local absolute_file_paths = {}
	for _, file_path in ipairs(relative_file_paths) do
		absolute_file_paths[#absolute_file_paths + 1] = vim.fn.fnamemodify(file_path, ":p")
	end

	return absolute_file_paths
end

local function filter_for_unique_files(files)
	return vim.list.unique(files)
end

local function is_file_open_in_tab(absolute_file_path)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local buf_file_name = vim.api.nvim_buf_get_name(buf)
			local absolute_buf_file_path = vim.fn.fnamemodify(buf_file_name, ":p")
			if absolute_buf_file_path == absolute_file_path then
				return true
			end
		end
	end

	return false
end

local function filter_for_files_currently_open_in_a_tab(list)
	local filtered_list = {}
	for _, file_name in ipairs(list) do
		if not is_file_open_in_tab(file_name) then
			filtered_list[#filtered_list + 1] = file_name
		end
	end
	return filtered_list
end

local function create_new_tab(file_names)
	for _, file_name in ipairs(file_names) do
		vim.cmd("tabnew " .. vim.fn.fnameescape(file_name))
	end
end

-- shortcut for tabnew which also allows multiple files at once
vim.api.nvim_create_user_command("Tn", function(opts)
	for _, pattern in ipairs(opts.fargs) do
		absolute_file_paths = get_absolute_file_paths_from_pattern(pattern)
		files_unique = filter_for_unique_files(absolute_file_paths)
		files_not_currently_open_in_a_tab = filter_for_files_currently_open_in_a_tab(absolute_file_paths)
		create_new_tab(files_not_currently_open_in_a_tab)
	end
end, {
	nargs = "+",
	complete = "file",
})
