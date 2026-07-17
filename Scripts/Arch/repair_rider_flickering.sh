#!/bin/bash

JETBRAINS_PATH="$HOME/.config/JetBrains"
CONFIG="-Dawt.toolkit.name=WLToolkit"

if [ ! -d "$JETBRAINS_PATH" ]; then
    echo "$JETBRAINS_PATH does not exist" >&2
    exit 1
fi

echo "Config: $CONFIG"

find "$JETBRAINS_PATH" -maxdepth 1 -type d -name "Rider*" | while read -r rider_dir; do
    [ -z "$rider_dir" ] && continue
    config_file="${rider_dir}/rider64.vmoptions"
    echo "$CONFIG" > "$config_file"
    echo "Wrote config to '$config_file'"
done

