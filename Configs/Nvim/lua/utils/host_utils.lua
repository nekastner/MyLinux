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

local function are_plugins_existing(linux_distro)
	if linux_distro == nil then
		return false
	end

	local path = vim.fn.stdpath("config") .. "/lua/plugins/" .. linux_distro
	local stat = vim.uv.fs_stat(path)
	if not stat or stat.type ~= "directory" then
		return false
	end

	local iter = vim.fs.dir(path)
	local first = iter()
	if not first then
		return false
	end

	return true
end

local function get_plugins_require_string(linux_distro)
	if linux_distro == nil then
		return nil
	end

	return "plugins." .. linux_distro
end

local function import_plugins(lazy)
	local linux_distro = get_linux_distro()

	if not are_plugins_existing(linux_distro) then
		return
	end

	lazy.setup(get_plugins_require_string(linux_distro))
end

return {
	import_plugins = import_plugins
}
