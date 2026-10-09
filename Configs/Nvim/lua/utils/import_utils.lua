local function get_module_names(path)
	local module_names = {}
	for name, type in vim.fs.dir(path) do
		if type == "file" and name ~= "init.lua" and name:match("%.lua$") then
			module_names[#module_names + 1] = name:gsub("%.lua$", "")
		end
	end
	return module_names
end

local function import(configs_dir_name)
	local path = vim.fn.stdpath("config") .. "/lua/" .. configs_dir_name .. "/"
	local require_prefix = configs_dir_name .. "."

	local configs = {}

	for _, module_name in ipairs(get_module_names(path)) do
		configs[module_name] = require(require_prefix .. module_name)
	end

	return configs
end

return {
	import = import
}
