hl.config({
    scrolling = {
        column_width = 0.5,
        fullscreen_on_one_column = true,
        focus_fit_method = 1,
        follow_min_visible = 0.35,
        wrap_focus = true,
        wrap_swapcol = true,
        direction = "right",
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
    },
})

for i = 1, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        layout = "scrolling",
    })
end

hl.workspace_rule({
    workspace = "special:scratch",
    layout = "scrolling",
})
