-- cursor
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- qt
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- gtk
hl.env("GTK_THEME", "Breeze-Dark")
hl.env("GTK_USE_PORTAL", 1)

-- hyprshot
hl.env("HYPRSHOT_DIR", "~/Pictures/Hyprshot")
hl.env("HYPRSHOT_FILENAME", "%Y-%m-%d_%H-%M-%S")
