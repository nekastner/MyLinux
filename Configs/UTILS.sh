is_path_in_home()
{
	local TARGET_PATH="$1"

	[[ "$TARGET_PATH" == "$HOME" ]] || [[ "$TARGET_PATH" == "$HOME"/* ]]
	return $?
}

is_target_linked_to_source()
{
	local TARGET="$1"
	local SOURCE="$2"

	[[ -L "$TARGET" ]] && [[ "$(realpath "$TARGET")" == "$SOURCE" ]]
	return $?
}

is_target_equal_to_source()
{
	local TARGET="$1"
	local SOURCE="$2"

	if ! [[ -d "$TARGET" ]];
	then
		cmp --silent "$SOURCE" "$TARGET"
		return $?
	else
		diff -qrr "$SOURCE" "$TARGET" >/dev/null 2>&1
		return $?
	fi
}

ask_user_default_no()
{
	local MSG="$1"

	read -rp "$MSG [y/N] " user_confirmation < /dev/tty

	[[ "$user_confirmation" =~ ^[yY]$ ]]
	return $?
}
