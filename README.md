# Cursor-Themed Wayland Environment

A minimalist, high-performance Wayland dotfile configuration designed specifically for low-spec hardware (such as Intel i3 processors with integrated graphics and 8GB RAM). It implements a strict "zero overhead" philosophy by utilizing compiled binaries and replacing heavy background daemons with lightweight, event-driven scripts.

## The Core Stack

- Compositor: Niri (Rust)
- Terminal: Foot (C)
- Launcher: Fuzzel (C)
- Status Bar: Ironbar (Rust)
- Auto-Theming Engine: Wallust (Rust)
- Wallpaper Engine: swww (Rust)

## Design Philosophy

This environment strictly adheres to the Cursor Design System, mimicking its editorial calm and magazine-like typographic voice.

- Typography: Utilizes Inter (fallback for CursorGothic) for UI elements and JetBrains Mono for all code and terminal surfaces.
- Geometry: Crisp 1px hairlines and 12px natively-clipped rounded corners.
- Fluid UI: Replicates Apple-like UI fluidity using Niri's asynchronous spring physics (damping ratio 0.85, stiffness 800) and exponential easing curves. This delivers heavy, bouncy macOS-style animations without taxing the CPU.
- Depth: Employs soft, downward-offset native drop shadows and optimized static background transparency (glassmorphism) to create depth without the GPU-heavy overhead of real-time blur.
- Status Bar: Features a fully rounded, circular pill-shaped Ironbar. Modules (CPU, RAM, Disk, Temp, Battery) are optimized to update every 15 seconds, and the clock updates every minute (60 seconds) to conserve CPU cycles.

## Dynamic Auto-Theming with Wallust

Rather than generating random color palettes that break the design system, this setup uses `wallust` to dynamically inject themes based on your wallpaper.

1. `wallust` extracts the dominant colors from the wallpaper.
2. It natively populates templates for `foot`, `fuzzel`, `ironbar`, and `niri` to apply the new color scheme seamlessly.
3. The script is entirely event-driven. It triggers only when you change the wallpaper via `Mod + W`, leaving zero background daemons running.

## Installation

Ensure your system is running Arch Linux (or a derivative) and execute the one-line installer script. The script will clone the repository, install necessary dependencies (including `wallust`), set up directories, and apply the default theme.

```bash
bash <(curl -s https://raw.githubusercontent.com/kenosis01/niri-dotfiles/main/install.sh)
```

## Usage

Keyboard bindings follow a familiar Windows layout schema:

### Application Launching
- Super + S: Open Fuzzel (App Launcher)
- Super + E: Open Thunar (File Explorer)
- Super + T: Open Foot (Terminal)

### Utilities
- Super + W: Open Wallpaper Picker. This uses Fuzzel to list all images in your `~/Pictures` and `~/Downloads` directories. Selecting one will instantly apply it and run `wallust` to re-theme the entire system.

### Window Management
- Alt + F4: Close Active Window
- Super + Left/Right/Up/Down: Focus directional columns/windows
- Super + V: Consume window into column (vertical stacking for a grid-like layout in Niri's horizontal ribbon)

### Hardware Controls
- F2 / F3: Volume Down / Up
- F6 / F7: Brightness Down / Up
