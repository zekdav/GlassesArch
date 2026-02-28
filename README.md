# Glass Hyprland Dotfiles

[![Arch Linux](https://img.shields.io/badge/Arch-Linux-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-000000?style=flat&logo=hyprland&logoColor=white)](https://hyprland.org/)

A beautifully customized, highly dynamic Hyprland setup for Arch Linux. Focused on seamless glassmorphism aesthetics, live video wallpapers, and 100% automated dynamic theming. 
### 📸 Desktop Overview

<table align="center" width="100%">
  <tr>
    <td colspan="3"><img src="demo/photo2.png" alt="Terminal and Waybar" width="100%"/></td>
    <td colspan="3"><img src="demo/photo1.png" alt="Clean Desktop" width="100%"/></td>
  </tr>
  
  <tr>
    <td colspan="2"><img src="demo/photo4.png" alt="Theme 1" width="100%"/></td>
    <td colspan="2"><img src="demo/photo5.png" alt="Theme 2" width="100%"/></td>
    <td colspan="2"><img src="demo/photo3.png" alt="Theme 3" width="100%"/></td>
  </tr>
  
  <tr>
    <td colspan="6"><img src="https://github.com/user-attachments/assets/35304d89-f164-4e93-8987-9e7b37cad49d" alt="Wlogout Menu" width="100%"/></td>
  </tr>
</table>

### 🎥 Live Preview

<div align="center">
  <video src="https://github.com/user-attachments/assets/6aa2f99d-8b1a-4505-8bfd-b29d9618adcb" autoplay loop muted controls playsinline width="500"></video>
</div>

---

## ✨ Key Features

* **True Dynamic Theming (`Wallust`)**: System colors are automatically generated on the fly. The custom scripts extract colors not only from static images but also grab frames from **.mp4 / .webm** video wallpapers to keep the theme perfectly synced.
* **Glassmorphism UI**: Waybar and Rofi feature a beautifully tuned, semi-transparent frosted glass effect that blends perfectly with bright and pastel wallpapers.
* **Live Video Wallpapers**: Powered by `Waypaper` + `mpvpaper`. Seamlessly cycle between `.jpg`, `.png`, `.mp4`, and `.gif` formats with a single keybind.
* **Animated Borders**: Active windows feature a smooth, infinitely rotating gradient border matching the current wallpaper palette.
* **Unified Ecosystem**: The dynamic colors automatically apply to:
    * Hyprland (Borders)
    * Waybar
    * Rofi (App Launcher)
    * Kitty (Terminal)

---

## 🧩 Components

* **Window Manager:** [Hyprland](https://hyprland.org/)
* **Bar:** [Waybar](https://github.com/Alexays/Waybar) (Custom Glassy CSS)
* **Launcher:** [Rofi-Wayland](https://github.com/lbonn/rofi)
* **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
* **Wallpaper Manager:** [Waypaper](https://github.com/anufrievroman/waypaper) (with `mpvpaper` and `swaybg`)
* **Color Generator:** [Wallust](https://codeberg.org/explosion-mental/wallust) (using `kmeans` backend and `softlight` palette)

---

## ⌨️ Keybinds

The main modifier key is `SUPER`.

**System & Actions:**
* `SUPER + W` = Cycle to the next wallpaper and extract a new color palette via Wallust
* `SUPER` = Open Rofi App Launcher
* `SUPER + N` = Open Notification Center (SwayNC)
* `SUPER + V` = Open Clipboard Manager
* `SUPER + Print` = Take a screenshot (Grim + Satty)
* `SUPER + CTRL + R` = Reload Hyprland configuration
* `Power Button` = Open fullscreen power menu (Wlogout)

**Applications:**
* `SUPER + Return` = Open Kitty Terminal
* `SUPER + B` = Open Firefox Developer Edition
* `SUPER + E` = Open File Manager (Nautilus)
* `SUPER + C` = Open VS Code

**Window Management:**
* `SUPER + Q` = Kill active window
* `SUPER + SHIFT + Q` = Kill active window and all open instances
* `SUPER + F` = Toggle fullscreen
* `SUPER + M` = Maximize window
* `SUPER + T` = Toggle floating mode for active window
* `SUPER + SHIFT + T` = Toggle all windows into floating mode
* `SUPER + J` = Toggle split
* `SUPER + K` = Swap split
* `SUPER + Left/Right/Up/Down` = Move focus between windows
* `SUPER + ALT + Left/Right/Up/Down` = Swap tiled windows
* `SUPER + SHIFT + Left/Right/Up/Down` = Resize active window
* `ALT + Tab` = Cycle between open windows and bring to top
* `SUPER + Left Mouse Button` = Move window
* `SUPER + Right Mouse Button` = Resize window

**Display & Zoom:**
* `SUPER + SHIFT + Mouse Scroll Up/Down` = Increase/Decrease display zoom
* `SUPER + SHIFT + Z` = Reset display zoom

**Workspaces:**
* `SUPER + [1-0]` = Switch to workspace 1-10
* `SUPER + SHIFT + [1-0]` = Move active window to workspace 1-10

**Function Keys (Fn):**
* `Volume Up/Down/Mute` = Control audio volume
* `Mic Mute` = Toggle microphone
* `Brightness Up/Down` = Control screen brightness
* `Keyboard Backlight Up/Down` = Control keyboard brightness
* `Media Play/Pause/Next/Prev` = Control media playback
* `Lock` = Lock screen (Hyprlock)
* `Calculator` = Open calculator
* `Tools` = Open ML4W Dotfiles Settings app

---

## ⚙️ Installation

1. Clone this repository to your home folder.
2. Ensure you have the required dependencies installed via `pacman` or `yay`:
   
   ```bash
   yay -S hyprland waybar rofi-wayland kitty waypaper mpvpaper swaybg wallust ffmpeg

3. Backup your existing configurations!

4. Copy the contents of the config folder to your ~/.config/ directory.

5. Place your favorite images and videos in ~/Pictures/wallpapers.

6. Press Super + W to initialize the dynamic theming script. Enjoy!
