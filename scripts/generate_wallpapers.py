import os
from PIL import Image, ImageDraw

def create_gradient(filename, width, height, color1, color2):
    img = Image.new("RGB", (width, height))
    draw = ImageDraw.Draw(img)
    for y in range(height):
        # Interpolate color
        r = int(color1[0] + (color2[0] - color1[0]) * y / height)
        g = int(color1[1] + (color2[1] - color1[1]) * y / height)
        b = int(color1[2] + (color2[2] - color1[2]) * y / height)
        draw.line([(0, y), (width, y)], fill=(r, g, b))
    img.save(filename)

# Cursor-inspired light wallpaper (Cream to Soft Peach)
create_gradient("wallpapers/light/cursor_cream.png", 1920, 1080, (247, 247, 244), (223, 168, 143))
# Cursor-inspired light wallpaper (Cream to Mint)
create_gradient("wallpapers/light/cursor_mint.png", 1920, 1080, (247, 247, 244), (159, 201, 162))

# Cursor-inspired dark wallpaper (Ink to Lavender)
create_gradient("wallpapers/dark/cursor_ink_lavender.png", 1920, 1080, (38, 37, 30), (192, 168, 221))
# Cursor-inspired dark wallpaper (Ink to Deep Orange)
create_gradient("wallpapers/dark/cursor_ink_orange.png", 1920, 1080, (38, 37, 30), (208, 66, 0))
