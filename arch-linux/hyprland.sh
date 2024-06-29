#!/usr/bin/env bash

sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2 qt5-wayland qt6-wayland \
    wofi xdg-desktop-portal-gtk xdg-utils dolphin glib2 gnome-themes-extra \
    eog keychain pamixer rhythmbox pavucontrol hyprland hyprpaper waybar \
    xdg-desktop-portal-hyprland

yay -S hyprpicker hyprshot-git mako-git swaylock-effects-git wl-clipboard-git \
    rofi-lbonn-wayland udiskie-systemd-git grim-git slurp-git pyprland-git

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

$SCRIPT_DIR/sddm.sh
