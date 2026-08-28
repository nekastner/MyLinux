#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

CONFIG_PATH="$SCRIPT_DIR/config.json"
CREDS_PATH="$SCRIPT_DIR/creds.json"

CONFIG_GENERATED_PATH="$SCRIPT_DIR/user_configuration.json"
CREDS_GENERATED_PATH="$SCRIPT_DIR/user_credentials.json"

ARGS=()

if [[ -f "$CONFIG_PATH" ]]; then
    ARGS+=(--config "$CONFIG_PATH")
fi

if [[ -f "$CREDS_PATH" ]]; then
    ARGS+=(--creds "$CREDS_PATH")
fi

if ! sudo archinstall "${ARGS[@]}"; then
    echo "ERROR: archinstall ist fehlgeschlagen." >&2
    exit 1
fi

echo "converting configs..."

chown_and_mv() {

	local source_path="$SCRIPT_DIR/$1"
	local target_path="$SCRIPT_DIR/$2"

	if [[ ! -f "$source_path" ]]; then
		return 0
	fi

	sudo chown "$USER":"$USER" "$source_path"
	mv "$source_path" "$target_path"
}

chown_and_mv "user_configuration.json" "config.json"
chown_and_mv "user_credentials.json" "creds.json"

echo "finished converting."

