#!/usr/bin/bash
# This script deppends on the https://github.com/ickyicky/window-calls extension

WINDOW_ID=`gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List | cut -c 3- | rev | cut -c4- | rev | jq -c '.[] | select (.wm_class == "'$1'") | .id' | awk 'NR==1{print $1}'`

if [ -z $WINDOW_ID ]; then
    bash -c $2
    exit 0
fi

CURR_WORKSPACE=`xdotool get_desktop`

gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.MoveToWorkspace $WINDOW_ID $CURR_WORKSPACE
gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.Maximize $WINDOW_ID
gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.Activate $WINDOW_ID
