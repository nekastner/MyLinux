local configs_dir_name = "configs"
local location = vim.fn.stdpath("config") .. "/lua/" .. configs_dir_name .. "/"
local require_prefix = "configs."

local function get_module_names()
	local module_names = {}
	for name, type in vim.fs.dir(location) do
		if type == "file" and name ~= "init.lua" and name:match("%.lua$") then
			module_names[#module_names + 1] = name:gsub("%.lua$", "")
		end
	end
	return module_names
end

local configs = {}
for _, module_name in ipairs(get_module_names()) do
	configs[module_name] = require(require_prefix .. module_name)
end
return configs
