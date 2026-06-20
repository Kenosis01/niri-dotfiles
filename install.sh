#!/usr/bin/env bash
# Auto-installer for Cursor-Themed Niri Dotfiles

echo "Installing Wayland dependencies..."
sudo pacman -S --needed --noconfirm niri foot fuzzel python python-pillow swww

echo "Installing Ironbar..."
cargo install ironbar

echo "Copying dotfiles to ~/.config..."
mkdir -p ~/.config
cp -r niri foot fuzzel ironbar scripts ~/.config/

echo "Setting permissions..."
chmod +x ~/.config/scripts/change-wallpaper.sh
chmod +x ~/.config/scripts/extract-theme.py
chmod +x ~/.config/scripts/route-downloads.sh

echo "Applying default theme..."
~/.config/scripts/change-wallpaper.sh ~/Pictures/Wallpapers/Dark/cursor_ink_lavender.png

echo "Installation complete! Please log out and start Niri."
