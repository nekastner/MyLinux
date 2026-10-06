local mainMod = "SUPER"

-- lock session
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- start applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))

-- move window focus inside workspace
for _, direction in ipairs({ "left", "right", "down", "up" }) do
	hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
end

-- move focus to workspaces 1 to 10
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- move focus to workspaces 11 to 20
for i = 11, 20 do
	local key = i % 10
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.focus({ workspace = i }))
end

-- toggle focus of magic workspace
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))

-- close window
hl.bind(mainMod .. " + C", hl.dsp.window.close())

-- kill window
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprctl kill"))

-- window movement
hl.bind(mainMod .. " + M", hl.dsp.submap("window_movement"))
hl.define_submap("window_movement", function()
	-- move window inside workspace
	for _, direction in ipairs({ "left", "right", "down", "up" }) do
		hl.bind(direction, hl.dsp.window.move({ direction = direction }))
	end

	-- move columns inside workspace
	for direction, abbreviation in pairs({ right = "r", left = "l" }) do
		hl.bind("CTRL + " .. direction, hl.dsp.layout("swapcol " .. abbreviation))
	end

	-- promote window to new column
	hl.bind(mainMod .. " + P", hl.dsp.layout("promote"))

	-- move window to workspaces 1 to 10
	for i = 1, 10 do
		local key = i % 10
		hl.bind(key, hl.dsp.window.move({ workspace = i }))
	end

	-- move window to workspaces 11 to 20
	for i = 11, 20 do
		local key = i % 10
		hl.bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end

	-- move window to magic workspace
	hl.bind("M", hl.dsp.focus({ workspace = "special:magic" }))

	-- move focus between all workspaces with the mouse
	hl.bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
	hl.bind("mouse_up", hl.dsp.focus({ workspace = "e-1" }))

	-- manipulate window size and position with the mouse
	hl.bind("mouse:272", hl.dsp.window.drag())
	hl.bind("mouse:273", hl.dsp.window.resize())

	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- take screenshots
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- sound settings
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioNext",
	hl.dsp.exec_cmd("playerctl next"),
	{ locked = true }
)
hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true }
)
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true }
)
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ locked = true }
)

-- brightness settings
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	{ locked = true, repeating = true }
)
