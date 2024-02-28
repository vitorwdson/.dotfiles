#!/usr/bin/env bash

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"

# Options
shutdown=''
reboot=''
lock=''
logout='󰍃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Goodbye" \
		-mesg "Uptime: $uptime" \
		-theme ~/.config/rofi/powermenu/theme.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Are you Sure?' \
		-theme ~/.config/rofi/powermenu/confirm.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--logout' ]]; then
			loginctl kill-user $(whoami)
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		swaylock
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
