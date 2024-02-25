sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2 qt5-wayland qt6-wayland \
    sddm wofi xdg-desktop-portal-gtk xdg-utils dolphin glib2

yay -S hyprland-git hyprpaper-git hyprpicker hyprshot-git mako-git \
    swaylock-effects-git thunar-csd waybar-git wl-clipboard-git wlogout \
    xdg-desktop-portal-hyprland-git

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

echo ""
read -p "Do you wish to enable sddm? (y/N): " confirm
echo ""

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo systemctl --enable sddm
fi
