sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2 qt5-wayland qt6-wayland \
    sddm wofi xdg-desktop-portal-gtk xdg-utils dolphin glib2

yay -S hyprland-git hyprpaper-git hyprpicker hyprshot-git mako-git \
    swaylock-effects-git thunar-csd waybar-git wl-clipboard-git wlogout \
    xdg-desktop-portal-hyprland-git sddm-theme-tokyo-night

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

sudo mkdir -p /etc/sddm.conf.d
sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
sudo sed -i 's@^Current=$@Current=tokyo-night-sddm@' /etc/sddm.conf.d/default.conf
sudo sed -i 's@^Numlock=none$@Numlock=on@' /etc/sddm.conf.d/default.conf
sudo sed -i 's@Background="Backgrounds/win11.png"@Background="Backgrounds/shacks.png"@' /usr/share/sddm/themes/tokyo-night-sddm/theme.conf

echo ""
read -p "Do you wish to enable sddm? (y/N): " confirm
echo ""

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo systemctl --enable sddm
fi
