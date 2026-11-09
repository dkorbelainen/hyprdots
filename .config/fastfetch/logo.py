#!/usr/bin/env python3
"""render logos/<name>.svg to a truecolor gradient ascii logo.txt for fastfetch"""
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
LOGOS = HERE / "logos"
OUT = HERE / "logo.txt"
SIZE = "40x20"
# light top-left -> dark bottom-right
STOPS = ("#d9c8ff", "#9c6ded", "#7c3aed")

Rgb = tuple[int, int, int]


def hex_rgb(h: str) -> Rgb:
    return (int(h[1:3], 16), int(h[3:5], 16), int(h[5:7], 16))


def color_at(t: float, stops: list[Rgb]) -> Rgb:
    t = min(max(t, 0.0), 1.0) * (len(stops) - 1)
    i = min(int(t), len(stops) - 2)
    f = t - i
    a, b = stops[i], stops[i + 1]
    return (
        round(a[0] + (b[0] - a[0]) * f),
        round(a[1] + (b[1] - a[1]) * f),
        round(a[2] + (b[2] - a[2]) * f),
    )


def render(svg: Path, size: str) -> list[str]:
    png = subprocess.run(
        ["rsvg-convert", "-h", "600", "-b", "white", str(svg)],
        check=True, capture_output=True,
    ).stdout
    txt = subprocess.run(
        ["chafa", "-f", "symbols", "--symbols", "ascii", "-c", "none",
         "--invert", "-s", size, "-"],
        check=True, capture_output=True, input=png,
    ).stdout.decode()
    return txt.rstrip("\n").split("\n")


def paint(lines: list[str], stops: list[Rgb]) -> str:
    rows = [i for i, l in enumerate(lines) if l.strip()]
    cols = [i for l in lines for i, c in enumerate(l) if c != " "]
    x0, x1, y0, y1 = min(cols), max(cols) + 1, rows[0], rows[-1] + 1
    out: list[str] = []
    for y, line in enumerate(lines):
        s = ""
        for x, c in enumerate(line):
            if c == " ":
                s += c
                continue
            r, g, b = color_at(((x - x0) / (x1 - x0) + (y - y0) / (y1 - y0)) / 2, stops)
            s += f"\x1b[38;2;{r};{g};{b}m{c}"
        out.append(s + "\x1b[0m")
    return "\n".join(out) + "\n"


def main() -> int:
    names = sorted(p.stem for p in LOGOS.glob("*.svg"))
    args = sys.argv[1:]
    if not args or args[0] not in names:
        print("usage: logo.py <name> [WxH]\nlogos:", *names)
        return 1
    size = args[1] if len(args) > 1 else SIZE
    OUT.write_text(paint(render(LOGOS / f"{args[0]}.svg", size), [hex_rgb(h) for h in STOPS]))
    return 0


if __name__ == "__main__":
    sys.exit(main())
