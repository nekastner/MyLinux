#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rm -rf "$HOME/.config/nivm"
ln -snf "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

