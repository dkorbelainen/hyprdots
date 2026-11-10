#!/usr/bin/env bash
# placeholder: replace the check below with your own vpn status command

if false; then # e.g. systemctl --user is-active --quiet your-vpn.service
    echo '{"text": "VPN 󰞀", "class": "connected", "tooltip": "VPN active"}'
else
    echo '{"text": "VPN 󰞀", "class": "disconnected", "tooltip": "VPN off"}'
fi
