local function get_linux_distro()
	local file = io.open("/etc/os-release", "r")

	if not file then
		return nil
	end

	for line in file:lines() do
		local id = line:match("^ID=(.*)")
		if id then
			file:close()
			return id:gsub('^"', ""):gsub('"$', "")
		end
	end

	file:close()
	return nil
end

local function setup_linux_distro_specific_plugins_dir(linux_distro)
	local path_to_distro_specific_plugins_dir = vim.fn.stdpath("config") .. "/plugins/" .. linux_distro
	vim.fn.mkdir(path_to_distro_specific_plugins_dir, "p")
end

local function get_linux_distro_specific_plugins_require_string(linux_distro)
	return "plugins." .. linux_distro
end

local linux_distro = get_linux_distro()

setup_linux_distro_specific_plugins_dir(linux_distro)

return {
	require_string_for_linux_distro_specific_plugins = get_linux_distro_specific_plugins_require_string(linux_distro)
}
