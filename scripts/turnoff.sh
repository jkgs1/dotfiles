#!/bin/bash
uptime=$(uptime -p | sed -e 's/up //g')
rofi_command="rofi "

shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
logout="Logout"

confirm_exit() {
	rofi -dmenu\
		-config\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "
}
msg() {
	rofi -no-config -e "Available Options - y / n"
}

options="$lock\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
       	$shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		elif [[ $ans == "n" || $ans == "N" ]]; then
			exit 0
		else 
			msg
		fi
	       	;;
	
	$reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "n" || $ans == "N" ]]; then
			exit 0
		else
			msg
		fi
	       	;;
	
	$lock)
		i3lock
	;;
	$logout)
		ans=$(confirm_exit &)
		if [[ $ans == "y" || $ans == "Y" ]]; then
			i3-msg exit
		elif [[ $ans == "n" || $ans == "N" ]]; then
			exit 0
		else 
			msg
		fi
		;;
esac
