#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_wallpaper>"
    exit 1
fi

WALLPAPER="$1"

# 1. Apply wallpaper
swww img "$WALLPAPER" --transition-type fade

# 2. Extract theme and inject using wallust
wallust run "$WALLPAPER"

# 3. Apply Niri borders dynamically
chmod +x ~/.config/scripts/niri-theme.sh
~/.config/scripts/niri-theme.sh

# 4. Reload components to apply new theme
killall ironbar
ironbar &
