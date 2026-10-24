hl.config({
	decoration = {
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			vibrancy = 0.18,
			new_optimizations = true,
			xray = false,
			noise = 0.03,
			contrast = 1.0,
			brightness = 1.0,
			popups = true,
			popups_ignorealpha = 0.15,
		},
	},
})

hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, ignore_alpha = 0 })
-- hl.layer_rule({ match = { namespace = "swaync" }, blur = true, ignore_alpha = 0 })
-- hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0, animation = "slide top" })
hl.layer_rule({ match = { namespace = "wlogout" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "hyprlock" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "zen-browser" }, blur = true, ignore_alpha = 0, animation = "fade" })
