-- startup
hl.on("hyprland.start", function()
	-- hl.exec_cmd("waybar") -- is now handled in host specific configs
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hyprpaper")
end)
