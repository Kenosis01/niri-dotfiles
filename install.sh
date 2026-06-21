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
sudo pacman -S --needed --noconfirm niri foot fuzzel python python-pillow swww git wallust

echo "Installing Ironbar..."
cargo install ironbar

echo "Copying dotfiles to ~/.config..."
mkdir -p ~/.config
cp -r niri foot fuzzel ironbar scripts wallust ~/.config/

# Move sample wallpapers to a standard location so the fallback works
mkdir -p ~/.config/wallpapers/Light ~/.config/wallpapers/Dark
python3 scripts/generate_wallpapers.py
cp -r ~/Pictures/Wallpapers/* ~/.config/wallpapers/ 2>/dev/null || true

echo "Setting permissions..."
chmod +x ~/.config/scripts/change-wallpaper.sh
chmod +x ~/.config/scripts/route-downloads.sh
chmod +x ~/.config/scripts/select-wallpaper.sh

echo "Applying default theme..."
~/.config/scripts/change-wallpaper.sh ~/.config/wallpapers/Dark/cursor_ink_lavender.png

# Cleanup if we cloned into tmp
if [ "$PWD" = "/tmp/niri-dotfiles" ]; then
    cd ~
    rm -rf /tmp/niri-dotfiles
fi

echo "Installation complete! Please log out and start Niri."
