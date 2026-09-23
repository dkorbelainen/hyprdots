#!/usr/bin/env bash

SERVICE="hysteria-client.service"

if systemctl --user is-active --quiet "$SERVICE"; then
    systemctl --user stop "$SERVICE"
    notify-send "Hysteria" "Disconnected" -i network-vpn-disconnected -u normal
else
    systemctl --user start "$SERVICE"
    notify-send "Hysteria" "Connected" -i network-vpn-acquiring -u normal
fi

pkill -RTMIN+8 waybar
