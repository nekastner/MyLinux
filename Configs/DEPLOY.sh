#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/DATA.sh"
source "$SCRIPT_DIR/UTILS.sh"

# ensure root rights are given
sudo -v

deploy()
{
	local SOURCE="$1"
	local TARGET="$2"
	local TARGET_DIR_NAME="$(dirname "$TARGET")"

	local MODE='' # options -> [ 'ln', 'cp' ]
	local USE_SUDO=0 # 0=no, 1=yes
	local EXEC_PREFIX='' # nothing or sudo
	if is_path_in_home "$TARGET";
	then
		MODE='ln'
	else
		MODE='cp'
		USE_SUDO=1
		EXEC_PREFIX='sudo'
	fi

	# if target already exists
	if [[ -e "$TARGET" ]];
	then
		# if target is linked to source
		if [[ "$MODE" == 'ln' ]] && is_target_linked_to_source "$TARGET" "$SOURCE";
		then
			printf "${_COLOR_GREEN}'$TARGET' already linked to '$SOURCE'!${_COLOR_NEUTRAL}\n"
			return 0;
		# if target is already equal to source
		elif [[ "$MODE" == 'cp' ]] && is_target_equal_to_source "$TARGET" "$SOURCE";
		then
			printf "${_COLOR_GREEN}'$TARGET' already equal to '$SOURCE'!${_COLOR_NEUTRAL}\n"
			return 0;
		# if target exists but is not up to date
		else
			printf "${_COLOR_YELLOW}WARNING ==> '$TARGET' already exists!${_COLOR_NEUTRAL}\n"
			if ! ask_user_default_no "Overwrite '$TARGET' with '$SOURCE'?";
			then
				printf "${_COLOR_RED}Aborted overwriting '$TARGET' by '$SOURCE'.${_COLOR_NEUTRAL}\n"
				return 1
			fi
		fi
	# if target does not already exist
	else
		if [[ "$MODE" == 'ln' ]];
		then
			if ! ask_user_default_no "Link '$SOURCE' to '$TARGET'?";
			then
				printf "${_COLOR_RED}Aborted linking '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
				return 1
			fi
		elif [[ "$MODE" == 'cp' ]];
		then
			if ! ask_user_default_no "Copy '$SOURCE' to '$TARGET'?";
			then
				printf "${_COLOR_RED}Aborted copying '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
				return 1
			fi
		fi
	fi

	# ensure target dir exists
	$EXEC_PREFIX mkdir -p "$TARGET_DIR_NAME"

	# clean up target
	$EXEC_PREFIX rm -rf "$TARGET"

	# link or copy source to target
	if [[ "$MODE" == 'ln' ]];
	then
		$EXEC_PREFIX ln -sf "$SOURCE" "$TARGET"
		printf "${_COLOR_GREEN}Linked '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
	elif [[ "$MODE" == 'cp' ]];
	then
		$EXEC_PREFIX cp -rf "$SOURCE" "$TARGET"
		printf "${_COLOR_GREEN}Copied '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
	fi

	# ensure correct ownership
	if [[ "$EXEC_PREFIX" == 'sudo' ]];
	then
		# should be redundant (linked or copied with sudo)
		$EXEC_PREFIX chown -R root:root "$TARGET"
		printf "${_COLOR_YELLOW}Changed ownership of '$TARGET' to 'root:root'!${_COLOR_NEUTRAL}\n"
	fi
}

for source_path in "${!SOURCES_TARGETS_LIST[@]}";
do
	target_path="${SOURCES_TARGETS_LIST[$source_path]}"
	deploy "$source_path" "$target_path"
done
