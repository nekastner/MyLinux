-- custom config import from hyprland.lua for specific hosts

local hostname = io.popen("hostname"):read("*l")
local config = string.format("%s/.config/hypr/%s.lua", os.getenv("HOME"), hostname)

local f = io.open(config, "r")
if f then
    f:close()
    dofile(config)
end

-- monitor configs

hl.monitor({
    output = "DP-1",
    mode = "preferred",
    position = "0x0",
    scale = 1,
    transform = 1, -- 90°
})
hl.monitor({
    output = "DP-2",
    mode = "preferred",
    position = "1440x0", --width and height toggle on ever 90° rotation
    scale = 1,
})

hl.workspace({
    id = 1,
    monitor = "DP-2",
})
hl.workspace({
    id = 2,
    monitor = "DP-2",
})