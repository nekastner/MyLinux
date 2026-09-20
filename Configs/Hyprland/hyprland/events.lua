-- startup
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprsunset --temperature 4500")
    hl.exec_cmd("hyprpaper")
end)

