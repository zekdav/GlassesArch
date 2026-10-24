local colors_ok, colors = pcall(dofile, os.getenv("HOME") .. "/.config/hypr/colors.lua")
if not colors_ok then
    colors = {
        background = "rgb(1a1a2e)",
        color4     = "rgb(566872)",
        color6     = "rgb(061820)",
    }
end

_G.wallust = colors


require("components.environments")
require("components.monitors")
require("components.general")
require("components.glass")
require("components.keyboard")
require("components.cursor")
require("components.animations")
require("components.layouts")
require("components.rules")
require("components.binds")
require("components.autostart")
