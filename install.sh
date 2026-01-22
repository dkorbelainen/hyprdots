#!/usr/bin/env bash
set -euo pipefail

# Symlinks dotfiles/configs into $HOME and optionally installs the SDDM theme.

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
WITH_SDDM=false
SUDO_BIN=${SUDO_BIN:-sudo}

usage() {
  cat <<'EOF'
Usage: ./install.sh [--sddm] [--no-sddm]

--sddm     Also install the SDDM theme (runs install-sddm.sh with sudo)
--no-sddm  Skip SDDM install (default)
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --sddm) WITH_SDDM=true ;;
    --no-sddm) WITH_SDDM=false ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

log() { printf '[hyprdots] %s\n' "$*"; }

die() { echo "$*" >&2; exit 1; }

link_path() {
  local src=$1 dest=$2
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="${dest}.bak.$(date +%s)"
    log "Backing up $dest -> $backup"
    mv "$dest" "$backup"
  fi
  install -d "$(dirname "$dest")"
  ln -s "$src" "$dest"
  log "Linked $dest -> $src"
}

link_user_configs() {
  mkdir -p "$HOME/.config"
  local configs=(fastfetch ghostty gtk-3.0 gtk-4.0 hypr micro nwg-look swaync tofi waybar wlogout)
  for cfg in "${configs[@]}"; do
    link_path "$ROOT_DIR/.config/$cfg" "$HOME/.config/$cfg"
  done
  link_path "$ROOT_DIR/.config/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
  link_path "$ROOT_DIR/.zshrc" "$HOME/.zshrc"
  if [[ -f "$ROOT_DIR/.p10k.zsh" ]]; then
    link_path "$ROOT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
  fi
}

link_user_configs

if $WITH_SDDM; then
  log "Installing SDDM theme as root"
  $SUDO_BIN "$ROOT_DIR/install-sddm.sh"
fi

log "All done. Restart your session to load the new configs."
