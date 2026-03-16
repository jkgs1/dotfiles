#!/bin/bash

current=$(hyprctl getoption general:layout | awk 'NR==1{print $2}')

if [[ "$current" == "dwindle" ]]; then
    hyprctl keyword general:layout master
else
    hyprctl keyword general:layout dwindle
fi
