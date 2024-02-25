#!/usr/bin/env bash

sudo sed -i '$a\setxkbmap -model pc105 -layout br -variant thinkpad' /usr/share/sddm/scripts/Xsetup
