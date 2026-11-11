local function is_pattern(pattern)
	return pattern:find("[*?%[{`]")
end

local function get_file_paths_from_pattern(pattern)
	if not is_pattern(pattern) then
		return { vim.fs.normalize(pattern) }
	end

	local file_paths = {}
	for _, path in ipairs(vim.fn.glob(pattern, true, true)) do
		if vim.fn.isdirectory(path) == 0 then
			file_paths[#file_paths + 1] = path
		end
	end

	if #file_paths == 0 then
		vim.notify("No file hits: " .. pattern, vim.log.levels.WARN)
	end

	return file_paths
end

local function normalize_and_absolute_path(path)
	return vim.fn.fnamemodify(vim.fs.normalize(path), ":p")
end

local function filter_for_unique_file_paths(file_paths)
	local seen, filtered = {}, {}

	for _, path in ipairs(file_paths) do
		local key = normalize_and_absolute_path(path)
		if not seen[key] then
			seen[key] = true
			filtered[#filtered + 1] = path
		end
	end
	return filtered
end

local function get_file_paths_open_in_tabs()
	local open = {}

	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
			local is_floating = vim.api.nvim_win_get_config(win).relative ~= ""

			if not is_floating then
				open[vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))] = true
			end
		end
	end

	return open
end

local function filter_out_already_visible_files(file_paths)
	local open = get_file_paths_open_in_tabs()
	local filtered_file_paths = {}

	for _, file_path in ipairs(file_paths) do
		if not open[normalize_and_absolute_path(file_path)] then
			filtered_file_paths[#filtered_file_paths + 1] = file_path
		end
	end

	return filtered_file_paths
end

local function create_new_tabs(file_paths)
	for _, file_path in ipairs(file_paths) do
		vim.cmd("tabnew " .. vim.fn.fnameescape(file_path))
	end
end

local function create_new_tab_from_patterns(patterns)
	local file_paths_from_patterns = {}

	for _, pattern in ipairs(patterns) do
		local file_paths_from_pattern = get_file_paths_from_pattern(pattern)
		vim.list_extend(file_paths_from_patterns, file_paths_from_pattern)
	end

	local file_paths_unique = filter_for_unique_file_paths(file_paths_from_patterns)
	local file_paths_not_already_visible = filter_out_already_visible_files(file_paths_unique)

	create_new_tabs(file_paths_not_already_visible)
end

-- shortcut for tabnew which also allows multiple files at once
vim.api.nvim_create_user_command("Tn", function(opts)
	local patterns = opts.fargs
	create_new_tab_from_patterns(patterns)
end, {
	nargs = "+",
	complete = "file",
})
