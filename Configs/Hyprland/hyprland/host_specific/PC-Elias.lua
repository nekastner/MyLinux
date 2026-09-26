hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@120",
	position = "0x0",
	scale = 1,
	transform = 0,
})
for i = 1, 10 do
	hl.workspace_rule({
		workspace = i,
		monitor = "HDMI-A-1",
	})
end


hl.monitor({
	output = "HDMI-A-2",
	mode = "1920x1080@60",
	position = "1920x0",
	scale = 1,
	transform = 3,
})
for i = 11, 20 do
	hl.workspace_rule({
		workspace = i,
		monitor = "HDMI-A-2",
	})
end
