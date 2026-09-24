#!/usr/bin/env bash

SERVICE="hysteria-client.service" # replace with your systemd user unit
CONFIG="$HOME/.hysteria/client.yaml"

if systemctl --user is-active --quiet "$SERVICE"; then
    server=$(awk '/^server:/ {print $2; exit}' "$CONFIG" 2>/dev/null)
    echo '{"text": "pandvpn 󰞀", "class": "connected", "tooltip": "VPN active ('"${server:-hysteria}"')"}'
else
    echo '{"text": "pandvpn 󰞀", "class": "disconnected", "tooltip": "VPN off"}'
fi
