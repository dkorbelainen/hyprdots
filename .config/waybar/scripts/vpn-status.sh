#!/usr/bin/env bash

SERVICE="hysteria-client.service"

if systemctl --user is-active --quiet "$SERVICE"; then
    echo '{"text": "hysteria 󰞀", "class": "connected", "tooltip": "Hysteria proxy active"}'
else
    echo '{"text": "hysteria 󰞀", "class": "disconnected", "tooltip": "Hysteria proxy off"}'
fi
