#!/bin/bash

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_YELLOW='\033[0;33m'

# pull new stand
if ! git -C "$CONFIGS_DIR" pull --rebase;
then
	printf "${_COLOR_RED}Error ==> Unable to git pull!${_COLOR_NEUTRAL}"
	exit 1
fi

# inform user about new status
if ! "$CONFIGS_DIR/STATUS.sh";
then
	# deploy new configs
	read -rp "Do you want to deploy? [y/N] " user_confirmation
	if [[ "&user_confirmation" =~ ^[yY]$ ]];
	then
		"$CONFIGS_DIR/DEPLOY.sh"
	fi
fi

# updates off running system
if [[ -e "$HOME/.zshrc" ]];
then
	printf "${_COLOR_YELLOW}INFO ==> ZSH requires a configuration reload!${_COLOR_NEUTRAL}"
fi
