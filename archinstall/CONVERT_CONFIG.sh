#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
SOURCE_PATH="$SCRIPT_DIR/user_configuration.json"
TARGET_PATH="$SCRIPT_DIR/config.json"

if [[ ! -f "$SOURCE_PATH" ]]; then
    echo "!!! ERR: '$SOURCE_PATH' not found."
    exit 1
fi

sudo chown $USER:$USER "$SOURCE_PATH"
mv "$SOURCE_PATH" "$TARGET_PATH"

