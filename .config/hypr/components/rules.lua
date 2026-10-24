hl.window_rule({
    match     = { class = "satty" },
    float     = true,
    center    = true,
    animation = "fade",
})

hl.window_rule({
    match     = { class = "Rofi" },
    float     = true,
    animation = "fade",
})

hl.window_rule({
    match     = { class = "org.gnome.Nautilus" },
    float     = true,
    animation = "fade",
    size      = { 900, 600 },
    center    = true,
})

hl.window_rule({
    match     = { class = "firefox%-developer%-edition", title = "Picture%-in%-Picture" },
    float     = true,
    pin       = true,
    animation = "fade",
    no_focus  = true,
})

hl.window_rule({
    name            = "neovim",
    match           = { class = "nvim" },
    border_size     = 0,
    scrolling_width = 1,
    rounding        = 0,
    opacity         = "1.0 override 1.0 override",
    immediate       = true,
})

hl.window_rule({
    name            = "codeoss",
    match           = { class = "code%-oss" },
    scrolling_width = 1,
    opacity         = "1.0 override 1.0 override",
    rounding        = 0,
    immediate       = true,
})

hl.window_rule({
    match           = { class = "kitty" },
    scrolling_width = 0.5,
    rounding        = 10,
    opacity         = "0.95 override 0.88 override",
})

hl.window_rule({
    match           = { class = "firefox%-developer%-edition" },
    scrolling_width = 0.8,
    opacity         = "1.0 override 1.0 override",
})

hl.window_rule({
    match       = { class = "gamescope" },
    fullscreen  = true,
    border_size = 0,
    no_blur     = true,
    no_shadow   = true,
    no_dim      = true,
    rounding    = 0,
    immediate   = true,
    xray        = false,
    content     = "game",
    no_vrr      = false,
})

hl.window_rule({
    match      = { class = "wlogout" },
    float      = true,
    fullscreen = true,
    animation  = "fade",
})

hl.window_rule({
    match      = { class = "hyprlock" },
    fullscreen = true,
    animation  = "fade",
})

hl.window_rule({
    match        = { class = "org.gnome.polkit%-gnome%-authentication%-agent%-1" },
    float        = true,
    center       = true,
    stay_focused = true,
    animation    = "fade",
})

hl.window_rule({
    match       = { float = true },
    rounding    = 10,
    border_size = 2,
})

hl.window_rule({
    match           = { fullscreen = true },
    border_size     = 0,
    rounding        = 0,
    no_blur         = true,
    no_shadow       = true,
    no_dim          = true,
    sync_fullscreen = true,
})
