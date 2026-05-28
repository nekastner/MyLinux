#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$HOME/.config"

rm -rf "$HOME/.config/hypr" 2> /dev/null
ln -snf "$SCRIPT_DIR/hypr" "$HOME/.config/hypr"

rm -rf "$HOME/.config/waybar" 2> /dev/null
ln -snf "$SCRIPT_DIR/waybar" "$HOME/.config/waybar"

