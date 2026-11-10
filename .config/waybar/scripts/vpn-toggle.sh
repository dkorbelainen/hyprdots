#!/usr/bin/env bash
# placeholder: replace the commands below with your own vpn start/stop

if false; then # same check as in vpn-status.sh
    : # your vpn stop command
    notify-send "VPN" "Disconnected" -i network-vpn-disconnected -u normal
else
    : # your vpn start command
    notify-send "VPN" "Connected" -i network-vpn-acquiring -u normal
fi

pkill -RTMIN+8 waybar
