function get_hostname()
	local hostname = ""
	local hostname_file = io.open("/etc/hostname", "r")
	if hostname_file then
		hostname = hostname_file:read("*l")
		hostname_file:close()
	end
	return hostname
end

function get_config_path(hostname)
	return string.format("%s/.config/hypr/hyprland/host_specific/%s.lua", os.getenv("HOME"), hostname)
end

function is_file_existing(filepath)
	if io.open(filepath, "r") then
		return true
	else
		return false
	end
end

function get_require_string(hostname)
	return string.format("hyprland.host_specific.%s", hostname)
end

local hostname = get_hostname()

return {
	is_config_existing = is_file_existing(get_config_path(hostname)),
	require_string = get_require_string(hostname),
}
