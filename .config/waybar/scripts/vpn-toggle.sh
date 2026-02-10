#!/usr/bin/env bash

INTERFACE="pandvpn" # replace with your interface name

if ip link show "$INTERFACE" > /dev/null 2>&1; then
    sudo wg-quick down pandvpn
    notify-send "VPN" "Disconnected" -i network-vpn-disconnected -u normal
else
    sudo wg-quick up pandvpn
    notify-send "VPN" "Connected" -i network-vpn-acquiring -u normal
fi

pkill -RTMIN+8 waybar
