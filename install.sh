#!/usr/bin/env bash
set -euo pipefail

# Symlinks dotfiles/configs into $HOME.

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

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
  local configs=(fastfetch ghostty hypr micro nwg-look swaync tofi waybar wlogout)
  for cfg in "${configs[@]}"; do
    link_path "$ROOT_DIR/.config/$cfg" "$HOME/.config/$cfg"
  done
  link_path "$ROOT_DIR/.config/spotify-launcher.conf" "$HOME/.config/spotify-launcher.conf"
  link_path "$ROOT_DIR/.zshrc" "$HOME/.zshrc"
  if [[ -f "$ROOT_DIR/.p10k.zsh" ]]; then
    link_path "$ROOT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
  fi
}

link_typora_theme() {
  local themes="$HOME/.config/Typora/themes"
  link_path "$ROOT_DIR/typora/themes/catppuccin" "$themes/catppuccin"
  link_path "$ROOT_DIR/typora/themes/catppuccin-mocha.css" "$themes/catppuccin-mocha.css"
}

set_default_markdown_editor() {
  if command -v xdg-mime >/dev/null; then
    xdg-mime default typora.desktop text/markdown text/x-markdown
    log "Default markdown editor: typora"
  fi
}

setup_directories() {
  mkdir -p "$HOME/Videos/replays"
  log "Created directory: $HOME/Videos/replays"
}

link_user_configs
link_typora_theme
set_default_markdown_editor
setup_directories

log "All done. Restart your session to load the new configs."
