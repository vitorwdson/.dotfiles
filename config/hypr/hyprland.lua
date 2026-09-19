-- Hyprland config — Lua format (Hyprland 0.55+)
-- Omarchy-based setup. Omarchy upstream ships these defaults under
-- $OMARCHY_PATH/default/hypr; here the tree is flattened into ~/.config/hypr.
-- Each require()d file is an isolated scope: an error in one file does not
-- stop the others from loading.

------------------------- MONITORS -------------------------
hl.monitor({ output = "", mode = "1920x1080@75", position = "auto", scale = 1 })

------------------------- BOOTSTRAP ------------------------
-- Wipes omarchy/hypr/theme modules so reloads pick up file changes and adds
-- ~/.local/state, ~/.config and $OMARCHY_PATH to package.path.
dofile((os.getenv("OMARCHY_PATH") or "/home/vitorwdson/.config") .. "/hypr/bootstrap.lua")

------------------------- OMARCHY DEFAULTS -----------------
-- Loads helpers, autostart, bindings, envs, looknfeel, input, windows, the
-- app window rules and the current theme's hyprland.lua.
-- Skip omarchy's default keybinds; conf/keybinds.lua holds the personal set.
_G.omarchy_default_bindings = false
require("hypr.omarchy")

------------------------- PERSONAL MODULES -----------------
require("hypr.conf.options")
require("hypr.conf.animations")
require("hypr.conf.rules")
require("hypr.conf.keybinds")
require("hypr.conf.environment")
