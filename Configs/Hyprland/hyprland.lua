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

local host_specific_config = require("hyprland.host_specific_config_utils")
if host_specific_config.is_config_existing then
	require(host_specific_config.require_string)
end
