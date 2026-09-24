#!/usr/bin/env bash

SERVICE="hysteria-client.service" # replace with your systemd user unit

if systemctl --user is-active --quiet "$SERVICE"; then
    systemctl --user stop "$SERVICE"
    notify-send "VPN" "Disconnected" -i network-vpn-disconnected -u normal
else
    systemctl --user start "$SERVICE"
    notify-send "VPN" "Connected" -i network-vpn-acquiring -u normal
fi

pkill -RTMIN+8 waybar
