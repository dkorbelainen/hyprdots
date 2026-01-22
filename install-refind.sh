#!/usr/bin/env bash
set -euo pipefail

# Copy the rEFInd config/theme from the repo into an EFI system partition.
# Usage: sudo EFI_ROOT=/boot/EFI ./install-refind.sh

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT_DIR/boot/EFI/refind"
EFI_ROOT=${EFI_ROOT:-/boot/EFI}
DEST="$EFI_ROOT/refind"

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "This script must run as root (use sudo)." >&2
  exit 1
fi

if [[ ! -d "$EFI_ROOT" ]]; then
  echo "EFI root $EFI_ROOT does not exist or is not mounted." >&2
  exit 1
fi

install -d "$DEST"
cp -r "$SRC"/. "$DEST"/

echo "rEFInd files copied to $DEST"
echo "Ensure \"include /EFI/refind/themes/catppuccin/mocha.conf\" in refind.conf matches your theme path."
