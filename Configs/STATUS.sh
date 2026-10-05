#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/DATA.sh"
source "$SCRIPT_DIR/UTILS.sh"

EXIT_CODE=0

function pprint
{
	local STATUSCOLOR="$1"
	local STATUS_TEXT="$2"
	local SOURCE="$3"
	local TARGET="$4"

	printf "[ ${STATUSCOLOR}${STATUS_TEXT}${COLOR_NEUTRAL} ] %-50s -> %s\n" "$SOURCE" "$TARGET"
}

function pprint_header
{
	pprint "COLOR_NEUTRAL" "STATUS" "SOURCE" "TARGET"
}

function pprint_is_target_linked_to_source
{
	local TARGET="$1"
	local SOURCE="$2"

	if ! is_target_linked_to_source "$TARGET" "$SOURCE"; then
		pprint "$COLOR_RED" "LINKED" "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$COLOR_GREEN" "LINKED" "$SOURCE" "$TARGET"
}

function pprint_is_target_equal_to_source
{
	local TARGET="$1"
	local SOURCE="$2"

	if ! is_target_equal_to_source "$TARGET" "$SOURCE"; then
		pprint "$COLOR_RED" "EQUAL " "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$COLOR_GREEN" "EQUAL " "$SOURCE" "$TARGET"
}

function pprint_status
{
	local SOURCE="$1"
	local TARGET="$2"

	if is_path_in_home "$TARGET"; then
		pprint_is_target_linked_to_source "$TARGET" "$SOURCE"
	else
		pprint_is_target_equal_to_source "$TARGET" "$SOURCE"
	fi
}

pprint_header

for source_path in "${!SOURCES_TARGETS_LIST[@]}"; do
	target_path="${SOURCES_TARGETS_LIST[$source_path]}"
	pprint_status "$source_path" "$target_path"
done

exit "$EXIT_CODE"
