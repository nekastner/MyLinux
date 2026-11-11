-- QUICK SETTINGS --

local mainMod = "SUPER"

local applications = {
	terminal = "kitty",
	webbrowser = "librewolf",
	filebrowser = "dolphin",
	launcher = "hyprlauncher",
}

-- SESSION CONTROL --

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- START APPLICATIONS --

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(applications.terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(applications.launcher))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(applications.filebrowser))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(applications.webbrowser))

-- MOVE FOCUS --

for direction, _ in pairs({ left = "left", right = "right", up = "up", down = "down" }) do
	hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
end

-- MOVE FOCUS BETWEEN WORKSPACES --

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

for i = 11, 20 do
	local key = i % 10
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.focus({ workspace = i }))
end

-- move focus between workspaces
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "e-1" }))

-- move focus between workspaces with mouse
hl.bind(mainMod .. " + CTRL + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

-- MOUSE CONTROL FOR WINDOWS --

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- MAGIC WORKSPACE --

hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))

-- WINDOW CLOSING --

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprctl kill"))

-- WAYBAR --

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -USR1 waybar"))

-- WINDOW MOVEMENT --

hl.bind(mainMod .. " + W", hl.dsp.submap("window_movement"))

hl.define_submap("window_movement", function()
	-- move window to directions
	for direction, _ in pairs({ left = "left", right = "right", up = "up", down = "down" }) do
		hl.bind(direction, hl.dsp.window.move({ direction = direction }))
	end

	-- move whole cols
	for direction, abbreviation in pairs({ left = "l", right = "r", up = "l", down = "r" }) do
		hl.bind("CTRL + " .. direction, hl.dsp.layout("swapcol " .. abbreviation))
	end

	-- promote window
	hl.bind(mainMod .. " + P", hl.dsp.layout("promote"))

	-- move window to other workspace
	for i = 1, 10 do
		local key = i % 10
		hl.bind(key, hl.dsp.window.move({ workspace = i }))
	end

	for i = 11, 20 do
		local key = i % 10
		hl.bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end

	-- magic workspace
	hl.bind("M", hl.dsp.window.move({ workspace = "special:magic" }))

	-- quit submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- SCREENSHOTS --

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- SOUND --

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

-- BRIGHTNESS --

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
