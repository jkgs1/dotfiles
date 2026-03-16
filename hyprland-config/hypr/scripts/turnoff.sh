#!/bin/bash

uptime=$(uptime -p | sed -e 's/up //g')

launcher="rofi --dmenu --prompt"

shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
logout="Logout"

confirm_exit() {
    echo -e "No\nYes" | wofi --dmenu --prompt "Are you sure?"
}

msg() {
    wofi --dmenu --prompt "Available Options - Yes / No"
}

options="$lock\n$logout\n$reboot\n$shutdown"

chosen=$(echo -e "$options" | wofi --dmenu --prompt "Uptime: $uptime")

case "$chosen" in
    "$shutdown")
        ans=$(confirm_exit)
        if [[ "$ans" == "Yes" ]]; then
            systemctl poweroff
        fi
        ;;
    
    "$reboot")
        ans=$(confirm_exit)
        if [[ "$ans" == "Yes" ]]; then
            systemctl reboot
        fi
        ;;
    
    "$lock")
        hyprlock
        ;;
    
    "$logout")
        ans=$(confirm_exit)
        if [[ "$ans" == "Yes" ]]; then
            hyprctl dispatch exit
        fi
        ;;
esac
