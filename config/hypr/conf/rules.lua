-- Window rules & workspace rules

------------------------- WINDOW RULES ---------------------
hl.window_rule({ match = { class = "^(kitty)$" },   opacity = "0.9 0.9" })
hl.window_rule({ match = { class = "^(vesktop)$" }, opacity = "0.9 0.9" })
hl.window_rule({ match = { class = "^(element)$" }, opacity = "0.9 0.9" })

hl.window_rule({ match = { class = "^(discord)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(vesktop)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(WebCord)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(Spotify)$" }, workspace = "4" })
hl.window_rule({ match = { title = "(Spotify)" },   workspace = "4" })
hl.window_rule({ match = { title = "(DBeaver)|(Dbeaver)" }, workspace = "6" })
hl.window_rule({ match = { class = "^(heroic)$" },  workspace = "10" })
hl.window_rule({ match = { class = "^(steam)$" },   workspace = "10" })
hl.window_rule({ match = { class = "^(steam_app_)" }, fullscreen = true })
-- windowrule = suppressevent maximize, match:class .*  (disabled)
hl.window_rule({ match = { class = "^(Minecraft.*)$" }, immediate = true })
hl.window_rule({ match = { title = "^(.*Network Manager.*)$" }, float = true })

-- Fix for xwaylandvideobridge white screen bug
-- hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override 0.0 override" })
-- hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true })
-- hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })
-- hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = { 1, 1 } })
-- hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true })

-- Fix for steam popups
hl.window_rule({ match = { title = "^()$", class = "^(steam)$" }, stay_focused = true })
hl.window_rule({ match = { title = "^()$", class = "^(steam)$" }, min_size = { 1, 1 } })

------------------------- WORKSPACE RULES ------------------
-- Pyprland stuff
hl.workspace_rule({
    workspace = "special:exposed",
    gaps_out = 60,
    gaps_in = 30,
    border_size = 5,
    no_shadow = true,
})
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
