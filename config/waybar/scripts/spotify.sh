#!/usr/bin/env bash

player_status=$(playerctl -p spotify status 2> /dev/null)
artist=$(playerctl -p spotify metadata artist)
title=$(playerctl -p spotify metadata title)

if [ "$player_status" = "Playing" ]; then
    echo '{"text": "󰓇 '"$artist - $title"'", "class": "playing", "alt": "Spotify"}'
elif [ "$player_status" = "Paused" ]; then
    echo '{"text": "󰏤 '"$artist - $title"'", "class": "", "alt": "Spotify (Paused)"}'
fi
