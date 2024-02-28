#!/usr/bin/env bash

sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2 qt5-wayland qt6-wayland \
    wofi xdg-desktop-portal-gtk xdg-utils dolphin glib2 gnome-themes-extra

yay -S hyprland-git hyprpaper-git hyprpicker hyprshot-git mako-git \
    swaylock-effects-git thunar-csd waybar-git wl-clipboard-git \
    xdg-desktop-portal-hyprland-git rofi-lbonn-wayland

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

$SCRIPT_DIR/sddm.sh
