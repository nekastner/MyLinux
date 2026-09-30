#!/bin/bash

EXIT_CODE=0

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/DATA.sh"
source "$SCRIPT_DIR/UTILS.sh"

pprint()
{
	local STATUS_COLOR="$1"
	local STATUS_TEXT="$2"
	local SOURCE="$3"
	local TARGET="$4"

	printf "[ ${STATUS_COLOR}${STATUS_TEXT}${_COLOR_NEUTRAL} ] %-50s -> %s\n" "$SOURCE" "$TARGET"
}

pprint_header()
{
	pprint "_COLOR_NEUTRAL" "STATUS" "SOURCE" "TARGET"
}

pprint_is_target_linked_to_source()
{
	local TARGET="$1"
	local SOURCE="$2"

	if ! is_target_linked_to_source "$TARGET" "$SOURCE";
	then
		pprint "$_COLOR_RED" "LINKED" "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$_COLOR_GREEN" "LINKED" "$SOURCE" "$TARGET"
}

pprint_is_target_equal_to_source()
{
	local TARGET="$1"
	local SOURCE="$2"

	if ! is_target_equal_to_source "$TARGET" "$SOURCE";
	then
		pprint "$_COLOR_RED" "EQUAL " "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$_COLOR_GREEN" "EQUAL " "$SOURCE" "$TARGET"
}

pprint_status()
{
	local SOURCE="$1"
	local TARGET="$2"

	if is_path_in_home "$TARGET";
	then
		pprint_is_target_linked_to_source "$TARGET" "$SOURCE"
	else
		pprint_is_target_equal_to_source "$TARGET" "$SOURCE"
	fi
}

pprint_header

for source_path in "${!SOURCES_TARGETS_LIST[@]}";
do
	target_path="${SOURCES_TARGETS_LIST[$source_path]}"
	pprint_status "$source_path" "$target_path"
done

exit "$EXIT_CODE"
