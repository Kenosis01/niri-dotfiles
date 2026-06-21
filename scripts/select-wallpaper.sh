#!/usr/bin/env bash

# Find all images in Pictures and Downloads
# Using find to locate jpg, jpeg, and png files
IMAGES=$(find ~/Pictures ~/Downloads -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) 2>/dev/null)

if [ -z "$IMAGES" ]; then
    # Fallback to default wallpapers if none found
    IMAGES=$(find ~/.config/wallpapers -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) 2>/dev/null)
fi

# Pipe the list of images to fuzzel in dmenu mode
SELECTED=$(echo "$IMAGES" | fuzzel -d -p "Select Wallpaper: " -l 15)

# If a selection was made, apply it
if [ -n "$SELECTED" ]; then
    ~/.config/scripts/change-wallpaper.sh "$SELECTED"
fi
