#!/usr/bin/env bash
# Auto-installer for Cursor-Themed Niri Dotfiles
# Repository: kenosis01/niri-dotfiles

# If running directly via curl, we need to clone the repo first
if [ ! -d "niri" ] && [ ! -d "foot" ]; then
    echo "Cloning kenosis01/niri-dotfiles..."
    git clone https://github.com/kenosis01/niri-dotfiles.git /tmp/niri-dotfiles
    cd /tmp/niri-dotfiles || exit 1
fi

echo "Installing Wayland dependencies..."
sudo pacman -S --needed --noconfirm base-devel niri foot fuzzel swww git wallust

echo "Installing Ironbar..."
# Using yay to install the pre-compiled binary instead of building from source via cargo
yay -S --noconfirm ironbar-bin

echo "Copying dotfiles to ~/.config..."
mkdir -p ~/.config
cp -r niri foot fuzzel ironbar scripts wallust ~/.config/

echo "Setting permissions..."
chmod +x ~/.config/scripts/change-wallpaper.sh
chmod +x ~/.config/scripts/route-downloads.sh
chmod +x ~/.config/scripts/select-wallpaper.sh

echo "Applying default theme..."
# Attempt to set an initial wallpaper if the user has any images
INITIAL_WALLPAPER=$(find ~/Pictures ~/Downloads -type f \( -iname "*.jpg" -o -iname "*.png" \) | head -n 1)
if [ -n "$INITIAL_WALLPAPER" ]; then
    ~/.config/scripts/change-wallpaper.sh "$INITIAL_WALLPAPER"
else
    echo "No wallpapers found in ~/Pictures or ~/Downloads. Please set one manually via Mod+W."
fi

# Cleanup if we cloned into tmp
if [ "$PWD" = "/tmp/niri-dotfiles" ]; then
    cd ~
    rm -rf /tmp/niri-dotfiles
fi

echo "Installation complete! Please log out and start Niri."
