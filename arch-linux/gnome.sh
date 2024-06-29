#!/usr/bin/env bash

sudo pacman -S gnome gnome-extra gnome-themes-extra gnome-shell-extension-appindicator
yay -S gnome-shell-extension-blur-my-shell gnome-shell-extension-dash-to-dock \
    nautilus-open-any-terminal 

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.shell disable-user-extensions false

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system

echo ""
read -p "Do you wish to enable gdm? (y/N): " confirm
echo ""

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo systemctl disable sddm
    sudo systemctl enable gdm 
fi
