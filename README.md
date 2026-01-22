# Hyprdots

Minimal Hyprland dotfiles with a quick install, a Tofi-powered screenshot helper (copy/save webp/png), and a Waybar VPN toggle.

## Quick start

```bash
git clone https://github.com/dkorbelainen/hyprdots.git
cd hyprdots
chmod +x install.sh install-sddm.sh
./install.sh --sddm   # drop --sddm if you only want user configs
```

What the scripts do:
- symlink repo configs into `~/.config` (hyprland, waybar, swaync, tofi, wlogout, ghostty, fastfetch, nwg-look, gtk3/gtk4, micro)
- link `.zshrc`, `.p10k.zsh`, `.gtkrc-2.0`
- with `--sddm`, call `install-sddm.sh` as root to install the theme, fonts, and `/etc/sddm.conf`

## Dependencies

Required to match the configs:
- Core: `hyprland`, `waybar`, `swaync`, `tofi`, `wlogout`
- Daemons: `hyprpaper`, `hypridle`, `hyprlock`
- Tools: `ghostty`, `fastfetch`, `micro`, `jq`
- Audio/brightness: `pipewire`/`wireplumber`, `pavucontrol`, `wpctl`, `brightnessctl`, `playerctl`
- Screenshots: `grim`, `slurp`, `wl-clipboard`, `imagemagick`
- Networking: `wireguard-tools`, `iproute2`
- Notifications: `libnotify` (`notify-send`)
- Theming: GTK 3/4, `nwg-look`, `fontconfig`, SDDM
- Themes/icons/cursor used in configs: Catppuccin GTK, Colloid icons, Bibata cursor
- Bootloader (optional): `refind`

Example (Arch-based distros):

```bash
sudo pacman -S hyprland waybar swaync tofi wlogout hyprpaper hypridle hyprlock ghostty fastfetch micro jq pipewire wireplumber pavucontrol brightnessctl playerctl grim slurp wl-clipboard imagemagick wireguard-tools iproute2 libnotify nwg-look sddm fontconfig zsh git
```

## rEFInd

rEFInd is a boot manager; it makes selecting between multiple OSes/kernels easy without fiddling with bootloader configs each time.

- Config: `boot/EFI/refind/refind.conf` includes Catppuccin themes.
- Theme is bundled under `boot/EFI/refind/themes/catppuccin/` (from Catppuccin rEFInd).
- Install steps (example):
  ```bash
  sudo mount /dev/<EFI_PARTITION> /boot/EFI   # ensure EFI is mounted
  sudo EFI_ROOT=/boot/EFI ./install-refind.sh
  ```
- After copying, tweak `default_selection` to your kernel label and `scanfor`/`timeout` as you like.

## Manual setup (not automated by scripts)

- SDDM/Hyprpaper backgrounds: a sample `wallpaper.jpg` is included and set in `sddm/themes/vitreous/vitreous.conf` under `Backgrounds/`. Replace with your file if desired.
- GTK theme/icon/cursor: install Catppuccin GTK, Colloid icons, and Bibata cursor yourself, then pick them in `nwg-look`.
- VPN widget: Waybar scripts assume interface name `pandvpn`; edit `~/.config/waybar/scripts/vpn-*.sh` to yours.
- Screenshot tool: `~/.config/hypr/hypr-screenshot` offers a Tofi menu to copy or save as webp/png into `~/Pictures/SS`. Ensure `grim`, `slurp`, `wl-clipboard`, `imagemagick`, and `tofi` are installed.
- Optional app binds: remove or remap keybinds for `spotify`, `Telegram`, `obsidian` if unused.