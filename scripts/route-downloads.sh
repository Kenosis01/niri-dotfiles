#!/usr/bin/env bash
# Lightweight script to route files from Downloads to appropriate directories

DOWNLOADS="$HOME/Downloads"
PICTURES="$HOME/Pictures"
VIDEOS="$HOME/Videos"
SCRIPTS="$HOME/Downloads/Scripts"

# Ensure target directories exist
mkdir -p "$PICTURES" "$VIDEOS" "$SCRIPTS"

# Find and move files appropriately
find "$DOWNLOADS" -maxdepth 1 -type f -iname "*.jpg" -exec mv {} "$PICTURES/" \;
find "$DOWNLOADS" -maxdepth 1 -type f -iname "*.png" -exec mv {} "$PICTURES/" \;
find "$DOWNLOADS" -maxdepth 1 -type f -iname "*.mp4" -exec mv {} "$VIDEOS/" \;
find "$DOWNLOADS" -maxdepth 1 -type f -iname "*.sh" -exec mv {} "$SCRIPTS/" \;
find "$DOWNLOADS" -maxdepth 1 -type f -iname "*.run" -exec mv {} "$SCRIPTS/" \;
