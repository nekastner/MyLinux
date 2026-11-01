local curves = {
	-- name, type, point1, point2
	{ "easeOutQuint",   "bezier", { 0.23, 1 },    { 0.32, 1 } },
	{ "easeInOutCubic", "bezier", { 0.65, 0.05 }, { 0.36, 1 } },
	{ "linear",         "bezier", { 0, 0 },       { 1, 1 } },
	{ "almostLinear",   "bezier", { 0.5, 0.5 },   { 0.75, 1 } },
	{ "quick",          "bezier", { 0.15, 0 },    { 0.1, 1 } }
}
for _, curve in ipairs(curves) do
	hl.curve(
		curve[1],
		{
			type = curve[2],
			points = {
				curve[3],
				curve[4],
			},
		}
	)
end

local anims = {
	-- leaf, enabled, speed, bezier, style
	{ "global",        10,   "default" },
	{ "border",        5.39, "easeOutQuint" },
	{ "windows",       4.79, "easeOutQuint" },
	{ "windowsIn",     4.1,  "easeOutQuint", "popin 87%" },
	{ "windowsOut",    1.49, "linear",       "popin 87%" },
	{ "fadeIn",        1.73, "almostLinear" },
	{ "fadeOut",       1.46, "almostLinear" },
	{ "fade",          3.03, "quick" },
	{ "layers",        3.81, "easeOutQuint" },
	{ "layersIn",      4,    "easeOutQuint", "fade" },
	{ "layersOut",     1.5,  "linear",       "fade" },
	{ "fadeLayersIn",  1.79, "almostLinear" },
	{ "fadeLayersOut", 1.39, "almostLinear" },
	{ "workspaces",    1.94, "almostLinear", "fade" },
	{ "workspacesIn",  1.21, "almostLinear", "fade" },
	{ "workspacesOut", 1.94, "almostLinear", "fade" },
	{ "zoomFactor",    7,    "quick" },
}
for _, anim in ipairs(anims) do
	hl.animation({
		leaf = anim[1],
		enabled = true,
		speed = anim[2],
		bezier = anim[3],
		style = anim[4],
	})
end

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 1,
		col = {
			active_border = "rgba(ffffffff)",
			inactive_border = "rgba(595959aa)",
		},
	},
	decoration = {
		rounding = 5,
		blur = {
			size = 3,
		},
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})
