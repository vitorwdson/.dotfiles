-- Curves & per-leaf animation settings (was: animations{} block)

-- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
for _, leaf in ipairs({
    "global", "border", "windows",
    "fadeIn", "fadeOut", "fade",
    "layers", "fadeLayersIn", "fadeLayersOut",
    "workspaces", "workspacesIn", "workspacesOut",
}) do
    hl.animation({ leaf = leaf, enabled = true, speed = 4, bezier = "default" })
end

hl.animation({ leaf = "windowsIn",  enabled = true, speed = 4, bezier = "default", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 87%" })
hl.animation({ leaf = "layersIn",   enabled = true, speed = 4, bezier = "default", style = "fade" })
hl.animation({ leaf = "layersOut",  enabled = true, speed = 4, bezier = "linear",  style = "fade" })
