-- Keybindings

local mainMod = "SUPER"

------------------------- GENERAL --------------------------
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("pypr toggle term && hyprctl dispatch bringactivetotop"))
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("omarchy-restart-shell"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("omarchy-menu toggle system"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("uwsm stop")) -- clean session exit under uwsm
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("omarchy-launch-nautilus"))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())

-- Omarchy app launcher / menu
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("omarchy-menu toggle apps"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("omarchy-menu toggle"))

-- Theme & background pickers: switcher prints the selection, then set applies it
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("bash -lc 'background=$(omarchy-theme-bg-switcher); [[ -n $background ]] && omarchy-theme-bg-set \"$background\"'"))
hl.bind(mainMod .. " + SHIFT + CTRL + SPACE", hl.dsp.exec_cmd("bash -lc 'theme=$(omarchy-theme-switcher); [[ -n $theme ]] && omarchy-theme-set \"$theme\"'"))

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
-- hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("hyprpicker -a -n -r"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pypr toggle volume && hyprctl dispatch bringactivetotop"))

------------------------- FOCUS ----------------------------
-- Move focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

------------------------- WORKSPACES -----------------------
-- Switch workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Brazilian (br) layout workspace keys
for _, b in ipairs({
    { mods = "",      key = "code:49",     ws = 1 },
    { mods = "SHIFT", key = "bracketleft", ws = 2 },
    { mods = "",      key = "bracketleft", ws = 3 },
    { mods = "SHIFT", key = "code:18",     ws = 4 },
    { mods = "SHIFT", key = "code:13",     ws = 5 },
    { mods = "SHIFT", key = "code:16",     ws = 6 },
    { mods = "SHIFT", key = "code:19",     ws = 7 },
    { mods = "",      key = "code:51",     ws = 8 },
    { mods = "SHIFT", key = "code:51",     ws = 9 },
    { mods = "SHIFT", key = "code:49",     ws = 10 },
}) do
    local shift = b.mods == "SHIFT" and " + SHIFT" or ""
    hl.bind(mainMod .. shift .. " + " .. b.key, hl.dsp.focus({ workspace = b.ws }))
    hl.bind(mainMod .. " + CTRL" .. shift .. " + " .. b.key, hl.dsp.window.move({ workspace = b.ws }))
end

-- Go/move to next/prev workspace
hl.bind(mainMod .. " + CTRL + J",  hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + K",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "e+1" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

------------------------- MOUSE ----------------------------
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------- SCREENSHOTS ----------------------
hl.bind("PRINT", hl.dsp.exec_cmd("omarchy-capture-screenshot region"))

-- Keep the old favourites working: omarchy-capture-screenshot region copies to
-- clipboard by default; these reproduce the old full-monitor shortcut.
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("omarchy-capture-screenshot fullscreen"))

------------------------- MEDIA KEYS -----------------------
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMute",  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
