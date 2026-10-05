local location = os.getenv("HOME") .. "/.config/hypr/hyprland/host_specific/"
local require_prefix = "hyprland.host_specific."

local function get_hostname()
	local hostname = ""
	local hostname_file = io.open("/etc/hostname", "r")
	if hostname_file then
		hostname = hostname_file:read("*l")
		hostname_file:close()
	end
	return hostname
end

local function is_host_specific_config_existing(hostname)
	local file_path = location .. hostname .. ".lua"
	local file = io.open(file_path, "r")

	if file then
		file:close()
		return true
	end

	return false
end

-- prepare data container
local host_specifc_config
local hostname = get_hostname()
if is_host_specific_config_existing(hostname) then
	host_specifc_config = require(require_prefix .. hostname)
else
	host_specifc_config = require(require_prefix .. "default")
end

return host_specifc_config
