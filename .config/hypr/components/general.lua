local c = _G.wallust or {}

local active_border
if c.color4 and c.color6 then
    active_border = { colors = { c.color4, c.color6 }, angle = 90 }
else
    active_border = { colors = { "rgb(566872)" } }
end

local inactive_border = { colors = { c.background or "rgb(1a1a2e)" } }

hl.config({
    general = {
        allow_tearing    = true,
        col              = {
            active_border   = active_border,
            inactive_border = inactive_border,
        },
        gaps_in          = 4,
        gaps_out         = 8,
        border_size      = 2,
        resize_on_border = true,
        layout           = "scrolling",
    },
    decoration = {
        rounding         = 10,
        rounding_power   = 2.0,
        active_opacity   = 1.0,
        inactive_opacity = 0.95,
        shadow           = {
            enabled        = true,
            range          = 20,
            render_power   = 3,
            color          = "rgba(1a1a2ecc)",
            color_inactive = "rgba(1a1a2e66)",
        },
    },
    xwayland = {
        force_zero_scaling = true,
    },
    misc = {
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        initial_workspace_tracking = 1,
        allow_session_lock_restore = true,
        vrr                        = 2,
    },
    binds = {
        movefocus_cycles_fullscreen = true,
    },
    animations = {
        enabled = true,
    },
})
