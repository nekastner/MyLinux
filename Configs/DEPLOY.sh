#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/DATA.sh"
source "$SCRIPT_DIR/UTILS.sh"

function deploy
{
	local SOURCE_PATH="$1"
	local TARGET_PATH="$2"

	local MODE EXEC_PREFIX
	if is_path_in_home "$TARGET_PATH"; then
		MODE='ln'
		EXEC_PREFIX=''
	else
		MODE='cp'
		EXEC_PREFIX='sudo'
	fi

	# if target already exists
	if [[ -e "$TARGET_PATH" ]]; then
		# if target is linked to source, inform user
		if [[ "$MODE" == 'ln' ]] && is_target_linked_to_source "$TARGET_PATH" "$SOURCE_PATH"; then
			printf "${COLOR_GREEN}'$TARGET_PATH' already linked to '$SOURCE_PATH'!${COLOR_NEUTRAL}\n"
			return 0;
		# if target is already equal to source, inform user
		elif [[ "$MODE" == 'cp' ]] && is_target_equal_to_source "$TARGET_PATH" "$SOURCE_PATH"; then
			printf "${COLOR_GREEN}'$TARGET_PATH' already equal to '$SOURCE_PATH'!${COLOR_NEUTRAL}\n"
			return 0;
		# if target exists but is not up to date, ask user for confirmation to overwrite
		else
			printf "${COLOR_YELLOW}WARNING ==> '$TARGET_PATH' already exists!${COLOR_NEUTRAL}\n"
			if ! ask_user_default_no "Overwrite '$TARGET_PATH' with '$SOURCE_PATH'?"; then
				printf "${COLOR_RED}Aborted overwriting '$TARGET_PATH' by '$SOURCE_PATH'.${COLOR_NEUTRAL}\n"
				return 1
			fi
		fi
	# if target does not already exist, ask user for confirmation
	else
		if [[ "$MODE" == 'ln' ]]; then
			if ! ask_user_default_no "Link '$SOURCE_PATH' to '$TARGET_PATH'?"; then
				printf "${COLOR_RED}Aborted linking '$SOURCE_PATH' to '$TARGET_PATH'.${COLOR_NEUTRAL}\n"
				return 1
			fi
		elif [[ "$MODE" == 'cp' ]]; then
			if ! ask_user_default_no "Copy '$SOURCE_PATH' to '$TARGET_PATH'?"; then
				printf "${COLOR_RED}Aborted copying '$SOURCE_PATH' to '$TARGET_PATH'.${COLOR_NEUTRAL}\n"
				return 1
			fi
		fi
	fi

	# ensure target root dir exists
	$EXEC_PREFIX mkdir -p "$(dirname "$TARGET_PATH")"

	# clean up target
	$EXEC_PREFIX rm -rf "$TARGET_PATH"

	# link source to target
	if [[ "$MODE" == 'ln' ]]; then
		$EXEC_PREFIX ln -sf "$SOURCE_PATH" "$TARGET_PATH"
		printf "${COLOR_GREEN}Linked '$SOURCE_PATH' to '$TARGET_PATH'.${COLOR_NEUTRAL}\n"
	# copy source to target
	elif [[ "$MODE" == 'cp' ]]; then
		$EXEC_PREFIX cp -rf "$SOURCE_PATH" "$TARGET_PATH"
		printf "${COLOR_GREEN}Copied '$SOURCE_PATH' to '$TARGET_PATH'.${COLOR_NEUTRAL}\n"
	fi
}

for source_path in "${!SOURCES_TARGETS_LIST[@]}"; do
	target_path="${SOURCES_TARGETS_LIST[$source_path]}"
	deploy "$source_path" "$target_path"
done
