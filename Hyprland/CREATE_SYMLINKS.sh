#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

ln -sf "$SCRIPT_DIR/hypr" ~/.config/hypr
ln -sf "$SCRIPT_DIR/waybar" ~/.config/waybar

