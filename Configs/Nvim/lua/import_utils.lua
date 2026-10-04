local import_utils = {}

local include_path_root = vim.fn.stdpath("config") .. "/lua/"

local lua_file_ending = "%.lua$"

local function make_configs_path(dir_name)
	return include_path_root .. dir_name
end

local function is_file_lua_config(name, type)
	return type == "file" and name:match(lua_file_ending)
end

local function make_import_string(dir_name, file_name)
	return dir_name .. "." .. file_name:gsub(lua_file_ending, "")
end

function import_utils.load_dir(dir_name)
	for name, type in vim.fs.dir(make_configs_path(dir_name)) do
		if is_file_lua_config(name, type) then
			require(make_import_string(dir_name, name))
		end
	end
end

return import_utils
