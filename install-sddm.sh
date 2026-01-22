#!/usr/bin/env bash

# Author: sane1090x (https://github.com/sane1090x)
# Copyright (C) 2025– sane1090x
# SPDX-License-Identifier: GPL-3.0-or-later

set -euo pipefail

# Installs the SDDM theme, fonts, and config from this repo into system paths.

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_SRC="$ROOT_DIR/sddm/themes/vitreous"
CONF_SRC="$ROOT_DIR/sddm/etc/sddm.conf"
FONT_SRC="$ROOT_DIR/sddm/fonts"

THEME_DEST="/usr/share/sddm/themes/vitreous"
CONF_DEST="/etc/sddm.conf"
FONT_DEST="/usr/local/share/fonts/hyprdots"

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "This script must run as root (use sudo)." >&2
  exit 1
fi

install -d "$THEME_DEST" "$FONT_DEST"

cp -r "$THEME_SRC"/. "$THEME_DEST"/
cp "$CONF_SRC" "$CONF_DEST"

# Preserve subdirectories when copying font files
find "$FONT_SRC" -type f \( -iname "*.ttf" -o -iname "*.otf" \) -print0 |
  while IFS= read -r -d '' file; do
    rel_path=${file#"$FONT_SRC/"}
    dest_dir="$FONT_DEST/$(dirname "$rel_path")"
    install -d "$dest_dir"
    install -m 0644 "$file" "$dest_dir/$(basename "$file")"
  done

# Ensure backgrounds folder exists even if user swaps assets later
install -d "$THEME_DEST/Backgrounds"

fc-cache -fv "$FONT_DEST"

echo "Installed SDDM theme to $THEME_DEST"
echo "Installed SDDM config to $CONF_DEST"
echo "Installed fonts to $FONT_DEST and refreshed font cache"
