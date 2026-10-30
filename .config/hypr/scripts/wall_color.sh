#!/bin/bash
IMG="$1"
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"

sed -i 's/palette = ".*/palette = "light"/' ~/.config/wallust/wallust.toml

wallust run -s "$IMG"

sleep 0.05

hyprctl reload
killall -SIGUSR2 waybar
swaync-client -rs

nice -n 19 "$SCRIPTS_DIR/sddm_blur.sh" "$IMG" &
