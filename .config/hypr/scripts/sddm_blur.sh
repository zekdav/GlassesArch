#!/bin/bash
magick "$1" -scale 960x600^ -gravity center -extent 960x600 -blur 0x8 -scale 1920x1200 /usr/share/sddm/themes/WhiteSur/blurred_wallpaper.jpg
