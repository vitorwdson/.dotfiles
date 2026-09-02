-- Hyprland config — Lua format (Hyprland 0.55+)
-- Entry point. Each require()d file is an isolated scope: an error in one
-- file does not stop the others from loading.

------------------------- MONITORS -------------------------
hl.monitor({ output = "", mode = "1920x1080@75", position = "auto", scale = 1 })

------------------------- MODULES --------------------------
require("conf/environment")
require("conf/options")
require("conf/animations")
require("conf/rules")
require("conf/keybinds")
