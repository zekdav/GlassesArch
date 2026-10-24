hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 23")
end)

hl.config({
    cursor = {
        no_hardware_cursors = true,
        no_break_fs_vrr     = false,
        enable_hyprcursor   = true,
    },
})
