#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/DATA.sh"
source "$SCRIPT_DIR/UTILS.sh"

# pull new stand
if ! git -C "$CONFIGS_DIR" pull --rebase;
then
	printf "${_COLOR_RED}Error ==> Unable to git pull!${_COLOR_NEUTRAL}"
	exit 1
fi

# inform user about new status
"$CONFIGS_DIR/STATUS.sh"

# if not everything is up to date and user confirms, run deploy
if ! $? && ask_user_default_no "Do you want to deploy?";
then
	"$CONFIGS_DIR/DEPLOY.sh"
fi
