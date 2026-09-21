hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

require("hyprland.keybinds")
require("hyprland.env")
require("hyprland.events")
require("hyprland.design")

local hostname_file = io.open("/etc/hostname", "r")
if hostname_file then
	local hostname = hostname_file:read("*l")
	hostname_file:close()
	local config = string.format("%s/.config/hypr/hyprland/host_specific/%s.lua", os.getenv("HOME"), hostname)
	local file = io.open(config, "r")
	if file then
	    file:close()
	    require(string.format("hyprland.host_specific.%s", hostname))
	end
end
