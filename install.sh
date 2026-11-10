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

apply_gtk_theme() {
  command -v gsettings >/dev/null || return 0
  local schema=org.gnome.desktop.interface
  gsettings set "$schema" gtk-theme "catppuccin-mocha-lavender-standard+default"
  gsettings set "$schema" icon-theme "Tela-circle-purple-dark"
  gsettings set "$schema" cursor-theme "Bibata-Modern-Ice"
  gsettings set "$schema" color-scheme "prefer-dark"
  log "Applied GTK theme, icons and cursor"
}

setup_spicetify() {
  command -v spicetify >/dev/null || return 0
  link_path "$ROOT_DIR/spicetify/Themes/catppuccin" "$(spicetify path userdata)/Themes/catppuccin"

  link_path "$ROOT_DIR/spicetify/CustomApps/marketplace" "$(spicetify path userdata)/CustomApps/marketplace"

  local spotify="$HOME/.local/share/spotify-launcher/install/usr/share/spotify"
  local prefs="$HOME/.config/spotify/prefs"
  if [[ ! -d "$spotify" || ! -f "$prefs" ]]; then
    log "Run spotify-launcher once, then re-run install.sh to apply the Spicetify theme"
    return
  fi
  spicetify config spotify_path "$spotify" prefs_path "$prefs" \
    current_theme catppuccin color_scheme mocha \
    inject_css 1 replace_colors 1 overwrite_assets 1 \
    inject_theme_js 1 custom_apps marketplace
  spicetify backup apply
}

setup_directories() {
  mkdir -p "$HOME/Videos/replays"
  log "Created directory: $HOME/Videos/replays"
}

link_user_configs
link_typora_theme
set_default_markdown_editor
apply_gtk_theme
setup_spicetify
setup_directories

log "All done. Restart your session to load the new configs."
