#!/usr/bin/env bash

sudo pacman -S --needed git base-devel
mkdir -p ~/.build-repos
git clone https://aur.archlinux.org/yay.git ~/.build-repos/yay
cd ~/.build-repos/yay && makepkg -si
