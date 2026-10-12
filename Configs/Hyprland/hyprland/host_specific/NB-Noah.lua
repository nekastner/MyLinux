-- horizontal monitor
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x1080",
	scale = 1,
	transform = 0,
})
for i = 1, 10 do
	hl.workspace_rule({
		workspace = i,
		monitor = "eDP-1",
	})
end

-- vertical monitor
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
	transform = 0,
})
for i = 11, 20 do
	hl.workspace_rule({
		workspace = i,
		monitor = "HDMI-A-1",
	})
end

-- startup
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar --config ~/.config/waybar/host_specific/NB-Noah.jsonc")
end)
