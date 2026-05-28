#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$HOME/.config"

rm -rf "$HOME/.config/nivm" 2> /dev/null
ln -snf "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

