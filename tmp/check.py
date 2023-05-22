#!/usr/bin/env python

from PIL import Image

image = Image.open('img/offset_paisaje.bmp')

pixels = image.load()

coords = []

offset = []

for y in range(image.height):
    for x in range(image.width):
        rgba = pixels[x, y]
        if rgba != (0, 0, 0):
            coords.append((x, y))
            offset.append(rgba)

image.close()

normal = []

image = Image.open('img/paisaje.bmp')

pixels = image.load()

for y in range(image.height):
    for x in range(image.width):
        rgba = pixels[x, y]
        print(f"\033[48:2:{rgba[2]}:{rgba[1]}:{rgba[0]}m({x}, {y}): 0xff{hex(rgba[2])[2:]}{hex(rgba[1])[2:]}{hex(rgba[0])[2:]}\033[0m")
# for x, y in coords:
#     rgba = pixels[x, y]
#     normal.append(rgba)

image.close()

# for i, coord in enumerate(coords):
#     diff = f"({abs(normal[i][0] - offset[i][0])}, {abs(normal[i][1] - offset[i][1])}, {abs(normal[i][2] - offset[i][2])})"
#     print(f"{coord}: {normal[i]}\t{offset[i]}, Diff: {diff}")
