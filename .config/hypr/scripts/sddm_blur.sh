#!/bin/bash
magick "$1" -scale 1920x1200^ -gravity center -extent 1920x1200 -blur 0x15 /usr/share/sddm/themes/WhiteSur/blurred_wallpaper.jpg
