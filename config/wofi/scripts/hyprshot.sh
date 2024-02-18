#!/usr/bin/env bash

options="Capture Region\nCapture Window\nCapture Screen"
selected=$(echo -e $options | wofi --show dmenu --width 300 --lines 7 --sort-order alphabetical)
sleep 0.5

case $selected in
    "Capture Region")
        hyprshot -m region
        ;;
    "Capture Window")
        hyprshot -m window -m active
        ;;
    "Capture Screen")
        hyprshot -m output -m HDMI-A-1
        ;;
esac
