#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_wallpaper>"
    exit 1
fi

WALLPAPER="$1"

# 1. Apply wallpaper
swww img "$WALLPAPER" --transition-type fade

# 2. Extract theme and generate configs
python3 ~/.config/scripts/extract-theme.py "$WALLPAPER"

# 3. Apply Niri borders dynamically
~/.config/scripts/niri-theme.sh

# 4. Reload components to apply new theme
# Reload ironbar
killall ironbar
ironbar &

# Reload fuzzel and foot (handled by including the theme file natively in their main configs, they will pick it up on next launch)
