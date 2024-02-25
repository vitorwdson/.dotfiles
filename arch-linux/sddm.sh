#!/usr/bin/env bash

sudo pacman -S sddm
yay -S sddm-theme-tokyo-night

sudo mkdir -p /etc/sddm.conf.d
sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
sudo sed -i 's@^Current=$@Current=tokyo-night-sddm@' /etc/sddm.conf.d/default.conf
sudo sed -i 's@^Numlock=none$@Numlock=on@' /etc/sddm.conf.d/default.conf
sudo sed -i 's@Background="Backgrounds/win11.png"@Background="Backgrounds/shacks.png"@' /usr/share/sddm/themes/tokyo-night-sddm/theme.conf

echo ""
read -p "Do you wish to enable sddm? (y/N): " confirm
echo ""

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo systemctl disable gdm
    sudo systemctl enable sddm
fi
