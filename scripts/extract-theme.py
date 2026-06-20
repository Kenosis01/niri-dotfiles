import sys
import os
from PIL import Image

def get_dominant_color(image_path):
    img = Image.open(image_path).convert('RGB')
    # Resize for faster processing
    img = img.resize((150, 150))
    colors = img.getcolors(22500)
    max_count = 0
    dominant_color = None
    for count, color in colors:
        if count > max_count:
            max_count = count
            dominant_color = color
    return dominant_color

def luminance(r, g, b):
    # Standard relative luminance calculation
    return 0.2126 * r + 0.7152 * g + 0.0722 * b

def rgb_to_hex(r, g, b):
    return f"{r:02x}{g:02x}{b:02x}"

def generate_theme(wallpaper_path):
    # Determine light or dark mode based on the directory path
    abs_path = os.path.abspath(wallpaper_path)
    is_light = "Light" in abs_path

    dom_color = get_dominant_color(wallpaper_path)

    # Base Cursor design colors locked
    if is_light:
        # Light mode: Canvas background, Ink text
        bg_rgb = (247, 247, 244) # Canvas
        fg_rgb = (38, 37, 30)    # Ink
        hairline = (230, 229, 224)
    else:
        # Dark mode: Ink background, Canvas text
        bg_rgb = (38, 37, 30)    # Ink
        fg_rgb = (247, 247, 244) # Canvas
        hairline = (50, 49, 42)

    # The dominant color becomes the accent color, replacing Cursor Orange
    accent_rgb = dom_color
    # If the dominant color lacks contrast with the background, fallback to Cursor Orange
    if abs(luminance(*accent_rgb) - luminance(*bg_rgb)) < 50:
        accent_rgb = (245, 78, 0) # Cursor Orange

    bg_hex = rgb_to_hex(*bg_rgb)
    fg_hex = rgb_to_hex(*fg_rgb)
    accent_hex = rgb_to_hex(*accent_rgb)
    hairline_hex = rgb_to_hex(*hairline)

    config_dir = os.path.expanduser("~/.config")

    # Generate Niri dynamic border colors (to be applied via CLI in bash script)
    with open(f"{config_dir}/scripts/niri-theme.sh", "w") as f:
        f.write(f"#!/usr/bin/env bash\n")
        f.write(f"niri msg action set-focus-ring-active-color '#{accent_hex}'\n")
        f.write(f"niri msg action set-border-active-color '#{accent_hex}'\n")
        f.write(f"niri msg action set-focus-ring-inactive-color '#{hairline_hex}'\n")
        f.write(f"niri msg action set-border-inactive-color '#{hairline_hex}'\n")
    os.chmod(f"{config_dir}/scripts/niri-theme.sh", 0o755)

    # Generate Foot colors
    with open(f"{config_dir}/foot/theme.ini", "w") as f:
        # 90% opacity for flat transparency (e6)
        f.write(f"[colors]\n")
        f.write(f"background={bg_hex}e6\n")
        f.write(f"foreground={fg_hex}\n")
        f.write(f"regular0={bg_hex}\n")
        f.write(f"regular1=cf2d56\n")
        f.write(f"regular2=1f8a65\n")
        f.write(f"regular3=c08532\n")
        f.write(f"regular4=9fbbe0\n")
        f.write(f"regular5=c0a8dd\n")
        f.write(f"regular6=9fc9a2\n")
        f.write(f"regular7={fg_hex}\n")
        f.write(f"selection-background={accent_hex}\n")
        f.write(f"selection-foreground={bg_hex}\n")

    # Generate Fuzzel colors
    with open(f"{config_dir}/fuzzel/theme.ini", "w") as f:
        f.write(f"[colors]\n")
        f.write(f"background={bg_hex}e6\n") # Transparency
        f.write(f"text={fg_hex}ff\n")
        f.write(f"match={accent_hex}ff\n")
        f.write(f"selection={hairline_hex}e6\n")
        f.write(f"selection-text={fg_hex}ff\n")
        f.write(f"selection-match={accent_hex}ff\n")
        f.write(f"border={hairline_hex}ff\n")

    # Generate Ironbar CSS variables
    with open(f"{config_dir}/ironbar/theme.css", "w") as f:
        f.write(f":root {{\n")
        # 85% opacity for flat transparency
        f.write(f"  --bg-color: rgba({bg_rgb[0]}, {bg_rgb[1]}, {bg_rgb[2]}, 0.85);\n")
        f.write(f"  --fg-color: #{fg_hex};\n")
        f.write(f"  --accent-color: #{accent_hex};\n")
        f.write(f"  --hairline-color: #{hairline_hex};\n")
        f.write(f"}}\n")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python extract-theme.py <wallpaper_path>")
        sys.exit(1)
    generate_theme(sys.argv[1])
