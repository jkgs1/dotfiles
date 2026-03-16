#!/usr/bin/env bash

# Theme configuration
dir="$HOME/.config/rofi/powermenu"
theme='style'

# System info
uptime="$(uptime -p | sed -e 's/up //g')"
host="$USER@$(cat /etc/hostname)"

# Options
shutdown="⏻ Shutdown"
reboot="󰜉 Reboot"
lock="󰌾 Lock"
logout="󰍃 Logout"

yes="Yes"
no="No"

# Rofi command
rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "Uptime: $uptime" \
        -theme ${dir}/${theme}.rasi
}

# Confirmation dialog
confirm_cmd() {
    rofi -dmenu \
        -p "Confirmation" \
        -mesg "Are you sure?" \
        -theme ${dir}/${theme}.rasi
}

# Ask confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Main menu
run_rofi() {
    echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute actions
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        case "$1" in
            --shutdown)
                systemctl poweroff
                ;;
            --reboot)
                systemctl reboot
                ;;
            --logout)
                hyprctl dispatch exit
                ;;
        esac
    fi
}

# Run menu
chosen="$(run_rofi)"

case "$chosen" in
    "$shutdown")
        run_cmd --shutdown
        ;;
    "$reboot")
        run_cmd --reboot
        ;;
    "$lock")
        hyprlock
        ;;
    "$logout")
        run_cmd --logout
        ;;
esac
