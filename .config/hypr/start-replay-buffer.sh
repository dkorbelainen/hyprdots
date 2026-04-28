#!/bin/bash
# ~/.config/hypr/start-replay-buffer.sh

# set to yours
SINK=
SOURCE=

# these are mine, dont mind
#SINK="alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y76XX8422E91C6-00.HiFi__Line__sink.monitor"
#SOURCE="alsa_input.usb-Focusrite_Scarlett_Solo_USB_Y76XX8422E91C6-00.HiFi__Mic1__source"
SAVE_DIR="$HOME/Videos/replays"

if ! pgrep -f "gpu-screen-recorder" > /dev/null; then
    mkdir -p "$HOME/Videos/replays"
    gpu-screen-recorder \
        -w screen \
        -f 60 \
        -a "$SINK|$SOURCE" \
        -ab 192 \
        -r 60 \
        -k h264 \
        -c mp4 \
        -o "$HOME/Videos/replays" &>/dev/null &
fi
