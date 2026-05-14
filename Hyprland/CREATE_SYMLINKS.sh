#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

ln -sf "$SCRIPT_DIR/hyprland.conf" ~/.config/hypr/hyprland.conf
ln -sf "$SCRIPT_DIR/hyprpaper.conf" ~/.config/hypr/hyprpaper.conf
ln -sf "$SCRIPT_DIR/hyprlock.conf" ~/.config/hypr/hyprlock.conf
ln -sf "$SCRIPT_DIR/hyprlock-bg.png" ~/.config/hypr/hyprlock-bg.png
ln -sf "$SCRIPT_DIR/waybar.conf" ~/.config/waybar/config

