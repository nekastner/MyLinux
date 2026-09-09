#!/bin/bash

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

RED='\033[0;31m'
NEUTRAL='\033[0m'

# pull new stand
if ! git -C "$CONFIGS_DIR" pull --rebase;
then
	printf "${RED}Error ==> Unable to git pull!${NEUTRAL}"
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
	source "$HOME/.zshrc"
fi
