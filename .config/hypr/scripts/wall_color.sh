#!/bin/bash
IMG="$1"

sed -i 's/palette = ".*/palette = "light"/' ~/.config/wallust/wallust.toml

wallust run "$IMG"

sleep 0.2

killall -SIGUSR2 waybar
swaync-client -rs