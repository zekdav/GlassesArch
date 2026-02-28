#!/bin/bash

DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.cache/current_wall_state"

if [ ! -d "$DIR" ]; then
    notify-send "Error" "Folder $DIR not found!"
    exit 1
fi

if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d '=' -f2 | xargs)
fi

CURRENT_NAME=$(basename "$CURRENT")

shopt -s nullglob nocaseglob
FILES=("$DIR"/*.{jpg,jpeg,png,webp,mp4,webm,mkv,gif})
ARRAY_LENGTH=${#FILES[@]}

if [ $ARRAY_LENGTH -eq 0 ]; then
    notify-send "Error" "There is no video or pictures in folder $DIR!"
    exit 1
fi

INDEX=0
for i in "${!FILES[@]}"; do
    if [[ "$(basename "${FILES[$i]}")" == "$CURRENT_NAME" ]]; then
        INDEX=$i
        break
    fi
done

NEXT_INDEX=$(( (INDEX + 1) % ARRAY_LENGTH ))
NEXT_WALL="${FILES[$NEXT_INDEX]}"

echo "$NEXT_WALL" > "$STATE_FILE"

killall -q waypaper mpvpaper swaybg 2>/dev/null
swaync-client -rs
sleep 0.2

waypaper --wallpaper "$NEXT_WALL"

EXT="${NEXT_WALL##*.}"
if [[ "${EXT,,}" =~ ^(mp4|webm|mkv|gif)$ ]]; then
    THUMB="/tmp/wallust_thumb.jpg"
    ffmpeg -y -i "$NEXT_WALL" -ss 00:00:01.000 -vframes 1 "$THUMB" -loglevel quiet
    ~/.config/hypr/scripts/wall_color.sh "$THUMB"
else
    ~/.config/hypr/scripts/wall_color.sh "$NEXT_WALL"
fi

notify-send "Wallpaper successfully changed" "$(basename "$NEXT_WALL")"