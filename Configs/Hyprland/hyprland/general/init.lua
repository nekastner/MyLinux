local lfs = require("lfs")

local location = os.getenv("HOME") .. "/.config/hypr/hyprland/general/"
local require_prefix = "hyprland.general."

local function get_module_names()
	local module_names = {}
	for file in lfs.dir(location) do
		if file ~= "." and file ~= ".." and file ~= "init.lua" and file:match("%.lua$") then
			module_names[#module_names + 1] = file:gsub("%.lua$", "")
		end
	end
	return module_names
end

local configs = {}
for _, module_name in ipairs(get_module_names()) do
	configs[module_name] = require(require_prefix .. module_name)
end
return configs
