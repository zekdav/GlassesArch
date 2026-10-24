#!/bin/bash
IMG="$1"
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"

sed -i 's/palette = ".*/palette = "light"/' ~/.config/wallust/wallust.toml

wallust run "$IMG"

sleep 0.2

hyprctl reload
killall -SIGUSR2 waybar
swaync-client -rs

"$SCRIPTS_DIR/sddm_blur.sh" "$IMG" &
