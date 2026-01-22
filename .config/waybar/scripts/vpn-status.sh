#!/usr/bin/env bash

INTERFACE="pandvpn"

if ip link show "$INTERFACE" > /dev/null 2>&1; then
    echo '{"text": "pandvpn 󰞀", "class": "connected", "tooltip": "VPN active ('"$INTERFACE"')"}'
else
    echo '{"text": "pandvpn 󰞀", "class": "disconnected", "tooltip": "VPN off"}'
fi
