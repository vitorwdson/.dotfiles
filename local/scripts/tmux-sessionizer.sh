#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find -L ~/Projects ~/.config  ~/.local ~/ -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
venv="$selected/venv"

if [[ -d $venv ]]; then
    venv="VIRTUAL_ENV=$venv"
else
    venv="VIRTUAL_ENV="
fi

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c "$selected" -e "$venv"
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c "$selected" -e "$venv"
fi

tmux switch-client -t $selected_name

