sudo pacman -S gnome gnome-extra gnome-themes-extra gnome-shell-extension-appindicator
yay -S gnome-shell-extension-blur-my-shell gnome-shell-extension-dash-to-dock

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.shell disable-user-extensions false

echo ""
read -p "Do you wish to enable gdm? (y/N): " confirm
echo ""

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo systemctl disable sddm
    sudo systemctl enable gdm 
fi
