#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/DATA.sh"
source "$SCRIPT_DIR/UTILS.sh"

function reverse_deploy
{
	local SOURCE_PATH="$1"
	local TARGET_PATH="$2"

	if ! [[ -e "$TARGET_PATH" ]]; then
		printf "${COLOR_RED}'$TARGET_PATH' does not exist!${COLOR_NEUTRAL}\n"
		return 1
	fi

	if is_target_equal_to_source "$TARGET_PATH" "$SOURCE_PATH"; then
		printf "${COLOR_GREEN}'$SOURCE_PATH' is already equal to '$TARGET_PATH'${COLOR_NEUTRAL}\n"
		return 0
	fi

	if is_target_linked_to_source "$TARGET_PATH" "$SOURCE_PATH"; then
		printf "${COLOR_GREEN}'$SOURCE_PATH' is already linked to '$TARGET_PATH'${COLOR_NEUTRAL}\n"
		return 0
	fi

	if ! ask_user_default_no "Overwrite '$SOURCE_PATH' by '$TARGET_PATH'?"; then
		printf "${COLOR_RED}Aborted overwriting!${COLOR_NEUTRAL}\n"
		return 1
	fi

	# ensure config dir exists
	mkdir -p "$(dirname "$SOURCE_PATH")"

	# clean up target
	rm -rf "$SOURCE_PATH"

	cp -rf "$TARGET_PATH" "$SOURCE_PATH"
	printf "${COLOR_GREEN}Copied '$TARGET_PATH' to '$SOURCE_PATH'.${COLOR_NEUTRAL}\n"
}

for source_path in "${!SOURCES_TARGETS_LIST[@]}"; do
	target_path="${SOURCES_TARGETS_LIST[$source_path]}"
	reverse_deploy "$source_path" "$target_path"
done
