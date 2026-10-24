hl.config({
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle,caps:none",
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity = 0,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3,
            tap_to_click = true,
            drag_lock = true,
            disable_while_typing = false,
        },
    },
    binds = {
        workspace_back_and_forth = false,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },
})

hl.device({
    name = "asuf1204:00-2808:0202-touchpad",
    enabled = false,
})
