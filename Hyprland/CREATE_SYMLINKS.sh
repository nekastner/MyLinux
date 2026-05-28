#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rm -rf "$HOME/.config/hypr"
ln -snf "$SCRIPT_DIR/hypr" "$HOME/.config/hypr"

rm -rf "$HOME/.config/waybar"
ln -snf "$SCRIPT_DIR/waybar" "$HOME/.config/waybar"

