-- Environment variables and autostart

------------------------- ENVIRONMENT ----------------------
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- for Qt apps
hl.env("LD_LIBRARY_PATH", "/run/current-system/sw/lib/pipewire")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/ssh-agent.socket")

------------------------- AUTOSTART (was exec-once) --------
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("swaync")
    hl.exec_cmd("pypr")
    hl.exec_cmd("solaar --window=hide")
    hl.exec_cmd("hyprctl setcursor Dracula-cursors 24")

    hl.exec_cmd("firefox", { workspace = "1 silent" })
    hl.exec_cmd("kitty --session ~/.config/kitty/startup.conf", { workspace = "2 silent" })
    hl.exec_cmd("vesktop", { workspace = "3 silent" })
    hl.exec_cmd("spotify", { workspace = "4 silent" })
end)

-- was `exec =` (runs on every reload)
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Dracula"')
hl.exec_cmd('gsettings set org.gnome.desktop.wm.preferences theme "Dracula"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"') -- for GTK4 apps
