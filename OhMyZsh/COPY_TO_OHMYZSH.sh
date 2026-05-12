#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

cp $SCRIPT_DIR/*.zsh ~/.oh-my-zsh/custom/

source ~/.zshrc

