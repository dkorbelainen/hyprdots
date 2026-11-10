<div align="center">

# 🌌 Hyprdots

**Minimal purple-themed Hyprland dotfiles**

<img src="previews/main.webp" alt="Hyprdots preview" width="90%">

<br>

![Hyprland](https://img.shields.io/badge/Hyprland-8b5cf6?style=for-the-badge&logo=hyprland&logoColor=white)
![Arch](https://img.shields.io/badge/Arch_Linux-1793d1?style=for-the-badge&logo=archlinux&logoColor=white)
![Catppuccin](https://img.shields.io/badge/Catppuccin-Mocha-b4befe?style=for-the-badge)

</div>

---

## Gallery

<table>
  <tr>
    <td width="50%"><img src="previews/terminal.webp" alt="Terminal"><br><sub><b>Terminal</b> — ghostty + fastfetch</sub></td>
    <td width="50%"><img src="previews/notifications.webp" alt="Notification center"><br><sub><b>Notification center</b> — SwayNC + Waybar VPN widget</sub></td>
  </tr>
  <tr>
    <td colspan="2"><img src="previews/editor.webp" alt="Editor"><br><sub><b>Editor</b> — micro</sub></td>
  </tr>
</table>

<table>
  <tr>
    <td width="33%"><img src="previews/hyprlock.png" alt="Hyprlock"><br><sub><b>hyprlock</b></sub></td>
    <td width="33%"><img src="previews/tofi.png" alt="Tofi"><br><sub><b>tofi</b> launcher</sub></td>
    <td width="33%"><img src="previews/wlogout.png" alt="wlogout"><br><sub><b>wlogout</b></sub></td>
  </tr>
</table>

## Quick start

```bash
git clone https://github.com/dkorbelainen/hyprdots.git
cd hyprdots
chmod +x install.sh
./install.sh
```

`install.sh` symlinks configs into `~/.config`, links the Typora theme, sets Typora as default markdown editor, applies the GTK theme, installs the Catppuccin Spicetify theme and Marketplace.

> [!NOTE]
> Install [dependencies](#-dependencies) first.

## Dependencies

<details>
<summary><b>Package list & install command</b></summary>

<br>

- **Core:** `hyprland`, `waybar`, `swaync`, `tofi`, `wlogout`
- **Daemons:** `hyprpaper`, `hypridle`, `hyprlock`
- **Tools:** `ghostty`, `fastfetch`, `micro`, `typora`, `spotify-launcher`, `spicetify-cli`, `jq`, `nwg-look`, `gpu-screen-recorder`
- **Audio/brightness:** `pipewire`/`wireplumber`, `pavucontrol`, `wpctl`, `brightnessctl`, `playerctl`
- **Screenshots:** `grim`, `slurp`, `wl-clipboard`, `imagemagick`
- **Networking:** `iproute2`
- **Notifications:** `libnotify` (`notify-send`)
- **Display manager (recommended):** SDDM with Astronaut theme

Arch-based distros:

```bash
sudo pacman -S spotify-launcher hyprland waybar swaync hyprpaper hypridle hyprlock ghostty fastfetch micro jq pipewire wireplumber pavucontrol gpu-screen-recorder brightnessctl playerctl grim slurp wl-clipboard imagemagick iproute2 libnotify nwg-look zsh git tela-circle-icon-theme-purple ffmpegthumbnailer gst-libav gst-plugins-ugly
yay -S tofi wlogout typora spicetify-cli bibata-cursor-theme catppuccin-gtk-theme-mocha sddm-astronaut-theme-git
chsh -s $(which zsh) # change your shell to zsh
source ~/.zshrc
```

</details>

## Manual setup

<details>
<summary><b>Steps the scripts don't cover</b></summary>

<br>

- **Monitor:** `hyprland.conf` uses `preferred` mode; set your own in `monitor=`.
- **Typora theme:** pick *Themes → Catppuccin Mocha* once in Typora.
- **Spotify:** launch `spotify-launcher` once, then re-run `./install.sh` to apply the Spicetify theme and Marketplace.
- **SDDM theme (optional):** [Astronaut theme](https://github.com/Keyitdev/sddm-astronaut-theme)
- **VPN widget:** set your VPN in `~/.config/waybar/scripts/vpn-status.sh` and `vpn-toggle.sh`.
- **Wallpaper / hyprlock avatar (optional):** replace `.config/hypr/wallpaper.jpg` and `.config/hypr/avatar.png` with your own.
- **rEFInd theme (optional):** `sudo EFI_ROOT=/boot/EFI ./install-refind.sh` copies the Catppuccin rEFInd config from `boot/EFI/refind`.

</details>

## Attributions

- Catppuccin themes/icons: MIT.
- Wallpaper `.config/hypr/wallpaper.jpg`: photo by Joshua Woroniecki, [Unsplash License](https://unsplash.com/photos/the-night-sky-is-filled-with-stars-and-trees-1ByBY06L-Z0).
