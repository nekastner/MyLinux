#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

_COLOR_NEUTRAL='\033[0m'
_COLOR_GREEN='\033[0;32m'
_COLOR_YELLOW='\033[0;33m'

if [[ ":$PATH:" != *":$SCRIPT_DIR:"* ]];
then
	export PATH="$PATH:$SCRIPT_DIR"
	printf "${_COLOR_GREEN}Added '$SCRIPT_DIR' to PATH.${_COLOR_NEUTRAL}\n"
else
	printf "${_COLOR_YELLOW}'$SCRIPT_DIR' was already in PATH!${_COLOR_NEUTRAL}\n"
	printf "It got not added twice."
fi