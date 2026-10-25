#!/bin/bash

# Prevent overlapping executions if user spams shortcut
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/cycle_wall.lock"
exec 200>"$LOCK_FILE"
flock -n 200 || exit 0

DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.cache/current_wall_state"
CACHE_DIR="$HOME/.cache/wallust_thumbs"
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
SOCKET="/tmp/mpv-socket-All"

mkdir -p "$CACHE_DIR" "$(dirname "$STATE_FILE")"

if [ ! -d "$DIR" ]; then
    notify-send -u critical "Wallpaper Error" "Folder $DIR not found!"
    flock -u 200
    exec 200>&-
    exit 1
fi

shopt -s nullglob nocaseglob
readarray -t FILES < <(find "$DIR" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \
    -o -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" -o -iname "*.gif" \
\) | sort -V)

ARRAY_LENGTH=${#FILES[@]}

if [ "$ARRAY_LENGTH" -eq 0 ]; then
    notify-send -u critical "Wallpaper Error" "No wallpapers found in $DIR!"
    flock -u 200
    exec 200>&-
    exit 1
fi

if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT=$(grep '^wallpaper =' ~/.config/waypaper/config.ini 2>/dev/null | cut -d '=' -f2 | xargs)
    CURRENT="${CURRENT/#\~/$HOME}"
fi

CURRENT_NAME=$(basename "$CURRENT")

INDEX=-1
for i in "${!FILES[@]}"; do
    if [[ "$(basename "${FILES[$i]}")" == "$CURRENT_NAME" ]]; then
        INDEX=$i
        break
    fi
done

NEXT_INDEX=$(( (INDEX + 1) % ARRAY_LENGTH ))
NEXT_WALL="${FILES[$NEXT_INDEX]}"
NEXT_WALL_NAME=$(basename "$NEXT_WALL")

# Change wallpaper seamlessly via mpvpaper socket
send_to_mpv() {
    [ -S "$SOCKET" ] && pgrep -x mpvpaper >/dev/null 2>&1 && \
    echo "loadfile \"$1\"" | socat - "$SOCKET" >/dev/null 2>&1
}

if ! send_to_mpv "$NEXT_WALL"; then
    killall -9 mpvpaper 2>/dev/null
    rm -f "$SOCKET"
    setsid -f mpvpaper -o "input-ipc-server=$SOCKET --idle=yes loop-file=inf image-display-duration=inf panscan=1.0 --mute=yes --background-color=#ffffff" '*' "$NEXT_WALL" 200>&- >/dev/null 2>&1
fi

echo "$NEXT_WALL" > "$STATE_FILE"

# Sync with waypaper config so reboot/restore preserves choice
if [ -f ~/.config/waypaper/config.ini ]; then
    sed -i "s|^wallpaper =.*|wallpaper = ${NEXT_WALL/#$HOME/~}|" ~/.config/waypaper/config.ini
fi

# Thumbnail extraction for video/gif wallpapers
EXT="${NEXT_WALL##*.}"
if [[ "${EXT,,}" =~ ^(mp4|webm|mkv|gif)$ ]]; then
    THUMB="$CACHE_DIR/thumb_${NEXT_WALL_NAME}.jpg"
    if [ ! -f "$THUMB" ]; then
        ffmpeg -y -i "$NEXT_WALL" -ss 00:00:01.000 -vframes 1 "$THUMB" -loglevel quiet
    fi
    PREVIEW_IMG="$THUMB"
else
    PREVIEW_IMG="$NEXT_WALL"
fi

# Send notification immediately with image icon and synchronous replace
notify-send -a "Wallpaper" -i "$PREVIEW_IMG" "Wallpaper changed" "$NEXT_WALL_NAME" -h string:x-canonical-private-synchronous:wallpaper

# Release lock before spawning background work so rapid cycling is not blocked
flock -u 200
exec 200>&-

# Update color schemes and system components in the background
"$SCRIPTS_DIR/wall_color.sh" "$PREVIEW_IMG" >/dev/null 2>&1 &
