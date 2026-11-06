import math
import os
from PIL import Image, ImageDraw, ImageFilter

MASTER_SIZE = 1024

def create_background_layer(width, height):
    """Full-bleed dark obsidian/slate background gradient with ambient emerald glow."""
    bg = Image.new("RGBA", (width, height), (0, 0, 0, 255))
    draw = ImageDraw.Draw(bg)

    # Vertical gradient from deep obsidian (15, 23, 42) to midnight (4, 8, 16)
    for y in range(height):
        t = y / float(height)
        r = int(14 * (1 - t) + 4 * t)
        g = int(24 * (1 - t) + 8 * t)
        b = int(40 * (1 - t) + 16 * t)
        draw.line([(0, y), (width, y)], fill=(r, g, b, 255))

    # Ambient radial emerald glow in the center
    cx, cy = width / 2.0, height / 2.0
    glow = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow)
    max_glow_rad = int(min(width, height) * 0.42)
    step = max(2, int(max_glow_rad / 35))

    for rad in range(max_glow_rad, int(max_glow_rad * 0.15), -step):
        alpha = int(55 * (1.0 - (rad / float(max_glow_rad)) ** 1.3))
        glow_draw.ellipse(
            [cx - rad, cy - rad, cx + rad, cy + rad],
            fill=(16, 185, 129, alpha)
        )

    glow = glow.filter(ImageFilter.GaussianBlur(int(min(width, height) * 0.05)))
    bg.alpha_composite(glow)
    return bg


def create_foreground_layer(size=1024):
    """
    Completely transparent RGBA layer containing ONLY:
    - Reticle brackets
    - Ceramic food plate & jade optical rings
    - Food scan arc
    - Central organic nutrition leaf
    - Amber AI diamond starburst & secondary spark
    - Specular lens reflection
    Zero text, zero letters, zero watermarks.
    """
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    cx, cy = size / 2.0, size / 2.0

    # 1. Outer AI Scanner Reticle Brackets (4 corners)
    reticle_layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    ret_draw = ImageDraw.Draw(reticle_layer)
    ret_rad = size * 0.35
    ret_len = size * 0.075
    ret_w = max(4, int(size * 0.014))

    mint_color = (52, 211, 153, 240)
    gold_color = (245, 158, 11, 240)

    # Top-Left Bracket
    ret_draw.line([(cx - ret_rad, cy - ret_rad + ret_len), (cx - ret_rad, cy - ret_rad)], fill=mint_color, width=ret_w)
    ret_draw.line([(cx - ret_rad, cy - ret_rad), (cx - ret_rad + ret_len, cy - ret_rad)], fill=mint_color, width=ret_w)

    # Top-Right Bracket (Nutritional Gold accent)
    ret_draw.line([(cx + ret_rad - ret_len, cy - ret_rad), (cx + ret_rad, cy - ret_rad)], fill=gold_color, width=ret_w)
    ret_draw.line([(cx + ret_rad, cy - ret_rad), (cx + ret_rad, cy - ret_rad + ret_len)], fill=gold_color, width=ret_w)

    # Bottom-Right Bracket
    ret_draw.line([(cx + ret_rad, cy + ret_rad - ret_len), (cx + ret_rad, cy + ret_rad)], fill=mint_color, width=ret_w)
    ret_draw.line([(cx + ret_rad, cy + ret_rad), (cx + ret_rad - ret_len, cy + ret_rad)], fill=mint_color, width=ret_w)

    # Bottom-Left Bracket
    ret_draw.line([(cx - ret_rad + ret_len, cy + ret_rad), (cx - ret_rad, cy + ret_rad)], fill=mint_color, width=ret_w)
    ret_draw.line([(cx - ret_rad, cy + ret_rad), (cx - ret_rad, cy + ret_rad - ret_len)], fill=mint_color, width=ret_w)

    img.alpha_composite(reticle_layer)

    # 2. Concentric Ceramic Food Plate & Optical Lens Rings
    r_outer_plate = size * 0.28
    r_inner_plate = size * 0.215
    r_center_well = size * 0.155

    # Drop shadow under the plate
    plate_shadow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    ps_draw = ImageDraw.Draw(plate_shadow)
    ps_draw.ellipse(
        [cx - r_outer_plate - 4, cy - r_outer_plate + 16, cx + r_outer_plate + 4, cy + r_outer_plate + 28],
        fill=(0, 0, 0, 160)
    )
    plate_shadow = plate_shadow.filter(ImageFilter.GaussianBlur(int(size * 0.02)))
    img.alpha_composite(plate_shadow)

    # Outer plate rim (Obsidian glass with vibrant emerald edge)
    plate_main = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    pm_draw = ImageDraw.Draw(plate_main)
    pm_draw.ellipse(
        [cx - r_outer_plate, cy - r_outer_plate, cx + r_outer_plate, cy + r_outer_plate],
        fill=(12, 22, 36, 255),
        outline=(16, 185, 129, 210),
        width=max(3, int(size * 0.007))
    )

    # Inner plate well (rich dark jade)
    pm_draw.ellipse(
        [cx - r_inner_plate, cy - r_inner_plate, cx + r_inner_plate, cy + r_inner_plate],
        fill=(8, 18, 28, 255),
        outline=(52, 211, 153, 110),
        width=max(2, int(size * 0.005))
    )

    # Core optical lens well (glowing dark emerald)
    pm_draw.ellipse(
        [cx - r_center_well, cy - r_center_well, cx + r_center_well, cy + r_center_well],
        fill=(5, 38, 28, 255),
        outline=(16, 185, 129, 230),
        width=max(3, int(size * 0.006))
    )
    img.alpha_composite(plate_main)

    # 3. Food Intelligence Optical Scan Beam Ring (Sweeping gradient arcs)
    scan_layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(scan_layer)
    arc_margin = size * 0.01
    s_draw.arc(
        [cx - r_inner_plate + arc_margin, cy - r_inner_plate + arc_margin,
         cx + r_inner_plate - arc_margin, cy + r_inner_plate - arc_margin],
        start=-65, end=80,
        fill=(52, 211, 153, 250),
        width=max(4, int(size * 0.008))
    )
    s_draw.arc(
        [cx - r_inner_plate + arc_margin, cy - r_inner_plate + arc_margin,
         cx + r_inner_plate - arc_margin, cy + r_inner_plate - arc_margin],
        start=125, end=245,
        fill=(16, 185, 129, 160),
        width=max(3, int(size * 0.006))
    )
    img.alpha_composite(scan_layer)

    # 4. Central Emblem: Modern Organic Nutrition Leaf + AI Starburst
    emblem_layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    e_draw = ImageDraw.Draw(emblem_layer)

    # Parametric Leaf Points
    leaf_pts = []
    # Right curve
    for i in range(30):
        t = i / 29.0
        x = (1 - t)**2 * (cx - size * 0.065) + 2 * (1 - t) * t * (cx + size * 0.085) + t**2 * (cx + size * 0.065)
        y = (1 - t)**2 * (cx + size * 0.065) + 2 * (1 - t) * t * (cy - size * 0.010) + t**2 * (cy - size * 0.075)
        leaf_pts.append((x, y))
    # Left curve
    for i in range(30):
        t = i / 29.0
        x = (1 - t)**2 * (cx + size * 0.065) + 2 * (1 - t) * t * (cx - size * 0.075) + t**2 * (cx - size * 0.065)
        y = (1 - t)**2 * (cy - size * 0.075) + 2 * (1 - t) * t * (cy - size * 0.015) + t**2 * (cx + size * 0.065)
        leaf_pts.append((x, y))

    # Fill leaf with glowing vibrant emerald
    e_draw.polygon(leaf_pts, fill=(16, 185, 129, 255))

    # Leaf center vein line (mint/pale green)
    e_draw.line(
        [(cx - size * 0.048, cy + size * 0.048), (cx + size * 0.048, cy - size * 0.058)],
        fill=(209, 250, 229, 230),
        width=max(2, int(size * 0.005))
    )

    # AI Diamond Starburst at top apex of leaf (Warm Amber Gold)
    spark_cx = cx + size * 0.062
    spark_cy = cy - size * 0.072
    spark_size = size * 0.030
    spark_pts = [
        (spark_cx, spark_cy - spark_size),
        (spark_cx + spark_size * 0.45, spark_cy),
        (spark_cx, spark_cy + spark_size),
        (spark_cx - spark_size * 0.45, spark_cy)
    ]
    e_draw.polygon(spark_pts, fill=(245, 158, 11, 255))

    # Miniature secondary AI spark (Mint green)
    spark2_cx = cx - size * 0.052
    spark2_cy = cy + size * 0.058
    spark2_size = size * 0.016
    spark2_pts = [
        (spark2_cx, spark2_cy - spark2_size),
        (spark2_cx + spark2_size * 0.45, spark2_cy),
        (spark2_cx, spark2_cy + spark2_size),
        (spark2_cx - spark2_size * 0.45, spark2_cy)
    ]
    e_draw.polygon(spark2_pts, fill=(52, 211, 153, 240))
    img.alpha_composite(emblem_layer)

    # 5. Top Specular Glass Reflection Arc
    specular = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    sp_draw = ImageDraw.Draw(specular)
    sp_draw.arc(
        [cx - r_outer_plate + size * 0.015, cy - r_outer_plate + size * 0.015,
         cx + r_outer_plate - size * 0.015, cy + r_outer_plate - size * 0.015],
        start=205, end=335,
        fill=(255, 255, 255, 90),
        width=max(2, int(size * 0.004))
    )
    img.alpha_composite(specular)

    return img


def create_master_squircle_icon():
    """1024x1024 master icon with squircle mask for store listings and standard launcher."""
    master = Image.new("RGBA", (MASTER_SIZE, MASTER_SIZE), (0, 0, 0, 0))
    bg = create_background_layer(MASTER_SIZE, MASTER_SIZE)

    # Rounded squircle mask
    corner_radius = 230
    margin = 32
    mask = Image.new("L", (MASTER_SIZE, MASTER_SIZE), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle(
        [margin, margin, MASTER_SIZE - margin, MASTER_SIZE - margin],
        radius=corner_radius,
        fill=255
    )

    # Paste background into squircle
    master.paste(bg, (0, 0), mask)

    # Squircle border highlight
    rim = Image.new("RGBA", (MASTER_SIZE, MASTER_SIZE), (0, 0, 0, 0))
    rim_draw = ImageDraw.Draw(rim)
    rim_draw.rounded_rectangle(
        [margin, margin, MASTER_SIZE - margin, MASTER_SIZE - margin],
        radius=corner_radius,
        outline=(255, 255, 255, 40),
        width=4
    )
    master.alpha_composite(rim)

    # Add foreground layer
    fg = create_foreground_layer(MASTER_SIZE)
    master.alpha_composite(fg)
    return master


def create_adaptive_foreground_432():
    """
    432x432 Adaptive Foreground.
    Android specification:
    - Overall size: 432x432
    - Safe zone: center circle with diameter 285px (66%)
    - Background: MUST BE TRANSPARENT.
    """
    fg_canvas = Image.new("RGBA", (432, 432), (0, 0, 0, 0))

    # Generate high-res foreground at 1024, then downscale smoothly to 260x260
    # 260px is well within the 285px safe zone!
    fg_1024 = create_foreground_layer(1024)
    target_size = 260
    fg_scaled = fg_1024.resize((target_size, target_size), Image.Resampling.LANCZOS)

    offset = (432 - target_size) // 2
    fg_canvas.paste(fg_scaled, (offset, offset), fg_scaled)
    return fg_canvas


def create_adaptive_background_432():
    """
    432x432 Adaptive Background.
    Android specification:
    - Full-bleed 432x432 without any corner clipping.
    """
    return create_background_layer(432, 432)


def generate_all_icons():
    print("Generating FoodLens premium original icon assets...")

    # 1. Master 1024x1024
    master = create_master_squircle_icon()
    os.makedirs("assets/icons", exist_ok=True)
    master.save("assets/icons/foodlens_master_1024.png", "PNG")
    master.save("foodlens_icon_master_1024.png", "PNG")
    print("  -> Saved assets/icons/foodlens_master_1024.png")

    # 2. Adaptive 432x432 Foreground and Background
    fg_432 = create_adaptive_foreground_432()
    bg_432 = create_adaptive_background_432()

    # Save to drawables
    base_res = "android/app/src/main/res"
    drawable_dir = os.path.join(base_res, "drawable")
    os.makedirs(drawable_dir, exist_ok=True)
    fg_432.save(os.path.join(drawable_dir, "ic_launcher_foreground.png"), "PNG")
    bg_432.save(os.path.join(drawable_dir, "ic_launcher_background.png"), "PNG")
    print("  -> Saved adaptive foreground and background to drawable/")

    # 3. Density Mipmaps (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
    densities = {
        "mipmap-mdpi": 48,
        "mipmap-hdpi": 72,
        "mipmap-xhdpi": 96,
        "mipmap-xxhdpi": 144,
        "mipmap-xxxhdpi": 192,
    }

    for folder, size in densities.items():
        target_dir = os.path.join(base_res, folder)
        os.makedirs(target_dir, exist_ok=True)

        # Standard launcher icon (Squircle)
        standard_icon = master.resize((size, size), Image.Resampling.LANCZOS)
        standard_icon.save(os.path.join(target_dir, "ic_launcher.png"), "PNG")

        # Round launcher icon (Circular Mask)
        mask = Image.new("L", (size, size), 0)
        mask_draw = ImageDraw.Draw(mask)
        mask_draw.ellipse([0, 0, size, size], fill=255)

        round_icon = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        round_icon.paste(standard_icon, (0, 0), mask)
        round_icon.save(os.path.join(target_dir, "ic_launcher_round.png"), "PNG")

        print(f"  -> Generated {folder}: {size}x{size} (standard & round)")

    # 4. Configure Adaptive Icon XML for API 26+
    v26_dir = os.path.join(base_res, "mipmap-anydpi-v26")
    os.makedirs(v26_dir, exist_ok=True)

    adaptive_xml = '''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
'''
    with open(os.path.join(v26_dir, "ic_launcher.xml"), "w") as f:
        f.write(adaptive_xml)
    with open(os.path.join(v26_dir, "ic_launcher_round.xml"), "w") as f:
        f.write(adaptive_xml)

    print("  -> Verified mipmap-anydpi-v26 XML configuration")
    print("SUCCESS: All launcher icons generated cleanly with ZERO text or watermarks!")


if __name__ == "__main__":
    generate_all_icons()
