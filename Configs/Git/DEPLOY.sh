#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

read -p "Overwrite existing '$HOME/.gitconfig'? [Y/n] " user_confirmation

if [[ $user_confirmation == [nN]* ]]; then
	echo 'Aborting...'
	exit 0
fi

rm -f "$HOME/.gitconfig"
ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
echo "Linked '$SCRIPT_DIR/.gitconfig' to '$HOME/.gitconfig'"

exit 0
