#!/bin/bash

EXIT_CODE=0

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIGS_DIR="$SCRIPT_DIR"

_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_GREEN='\033[0;32m'

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

# output header
pprint_header

#					SOURCE											TARGET

# refind
pprint_status		"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"
pprint_status		"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"

# kernel presets
pprint_status		"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"
pprint_status		"$CONFIGS_DIR/KernelPresets/linux-zen.preset"	"/etc/mkinitcpio.d/linux-zen.preset"

# oh my zsh
pprint_status		"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"
for config in		"$CONFIGS_DIR/OhMyZsh/"*;
do
	config_name="$(basename "$config")"
	pprint_status	"$config"										"$HOME/.oh-my-zsh/custom/$config_name"
done

# git
pprint_status		"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"

# nvim
pprint_status		"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"

# vim
pprint_status		"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"

# nano
pprint_status		"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"

# clang
pprint_status		"$CONFIGS_DIR/Clang/.clang-format"				"$HOME/.clang-format"

# samba
pprint_status		"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"
pprint_status		"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"

# nginx
pprint_status		"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"
pprint_status		"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"

# hyprland
pprint_status		"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"

# waybar
pprint_status		"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"

# mimeapps list
pprint_status		"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"

# mango hud
pprint_status		"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"

# return exit code to caller
exit "$EXIT_CODE"
