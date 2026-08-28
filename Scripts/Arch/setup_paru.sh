#!/bin/bash

if command -v paru &> /dev/null; then
    exit 0
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

sudo pacman -S --needed --noconfirm git base-devel
"$SCRIPT_DIR/setup_rust.sh"

git clone https://aur.archlinux.org/paru.git

cd paru
makepkg -si

cd ..
rm -rf paru

