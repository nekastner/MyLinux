--[[
hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "HDMI-A-2",
	mode = "preferred",
	position = "1920x0",
	scale = 1,
	transform = 1,
})

for i = 1, 8 do
	hl.workspace({
		id = i,
		monitor = "HDMI-A-1",
	})
end

for i = 9, 10 do
	hl.workspace({
		id = i,
		monitor = "HDMI-A-2",
	})
end
]]
