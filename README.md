# Cursor-Themed Wayland Environment

A minimalist, high-performance Wayland dotfile configuration designed specifically for low-spec hardware (such as Intel i3 processors with integrated graphics and 8GB RAM). It implements a strict "zero overhead" philosophy by utilizing compiled binaries and replacing heavy background daemons with lightweight, event-driven scripts.

## The Core Stack

- Compositor: Niri (Rust)
- Terminal: Foot (C)
- Launcher: Fuzzel (C)
- Status Bar: Ironbar (Rust)
- Wallpaper Engine: swww (Rust)

## Design Philosophy

This environment strictly adheres to the Cursor Design System, mimicking its editorial calm and magazine-like typographic voice.

- Base Theme: Locked to Cursor Canvas (warm cream #f7f7f4) for light mode, and Cursor Ink (warm near-black #26251e) for dark mode.
- Typography: Utilizes Inter (fallback for CursorGothic) for UI elements and JetBrains Mono for all code and terminal surfaces.
- Geometry: Crisp 1px hairlines and 12px natively-clipped rounded corners.
- Fluid UI: Replicates Apple-like UI fluidity using Niri's asynchronous spring physics (damping ratio 0.85, stiffness 800) and exponential easing curves. This delivers heavy, bouncy macOS-style animations without taxing the CPU.
- Depth: Employs soft, downward-offset native drop shadows and optimized static background transparency (glassmorphism) to create depth without the GPU-heavy overhead of real-time blur.

## Hybrid Auto-Theming

Rather than generating random color palettes that break the design system, this setup uses a dynamic hybrid auto-theming engine powered by Python (Pillow).

1. A lightweight, one-shot Python script calculates the average luminance of your selected wallpaper.
2. If the wallpaper is bright, it locks the base system theme to Cursor Canvas (Light mode). If dark, it locks to Cursor Ink (Dark mode).
3. It then extracts the dominant color from the wallpaper.
4. This extracted color replaces "Cursor Orange" to dynamically theme active window borders, terminal selections, and active workspaces.
5. The script exits immediately after generation, leaving zero background processes running.

## Installation

Ensure your system is running Arch Linux (or a derivative) and execute the one-line installer script. The script will clone the repository, install necessary dependencies, set up directories, and apply the default theme.

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
- Super + W: Open Wallpaper Picker. This uses Fuzzel to list all images in your `~/Pictures` and `~/Downloads` directories. Selecting one will instantly apply it and dynamically re-theme your entire system.

### Window Management
- Alt + F4: Close Active Window
- Super + Left/Right/Up/Down: Focus directional columns/windows
- Super + V: Consume window into column (vertical stacking for a grid-like layout in Niri's horizontal ribbon)

### Hardware Controls
- F2 / F3: Volume Down / Up
- F6 / F7: Brightness Down / Up
