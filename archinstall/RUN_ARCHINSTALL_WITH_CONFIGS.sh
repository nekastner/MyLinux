#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

sudo archinstall --config "$SCRIPT_DIR/config.json" --creds "$SCRIPT_DIR/creds.json"

