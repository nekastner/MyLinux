#!/bin/bash

EXIT_CODE=0

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_GREEN='\033[0;32m'

pprint()
{
	local STATUS_COLOR="$1"
	local STATUS_TEXT="$2"
	local SOURCE="$3"
	local TARGET="$4"

	printf "[ ${STATUS_COLOR}${STATUS_TEXT}${_COLOR_NEUTRAL} ] %-50s -> %s\n" "$TARGET" "$SOURCE"
}

is_linked()
{
	local SOURCE="$1"
	local TARGET="$2"

	if [[ ! -e "$TARGET" || ! -L "$TARGET" || ! "$(realpath "$TARGET")" = "$SOURCE" ]];
	then
		pprint "$_COLOR_RED" "LINKED" "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$_COLOR_GREEN" "LINKED" "$SOURCE" "$TARGET"
}

has_same_content()
{
	local SOURCE="$1"
	local TARGET="$2"

	if [[ ! -e "$TARGET" ]] || ! cmp --silent "$SOURCE" "$TARGET";
	then
		pprint "$_COLOR_RED" "EQUAL " "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$_COLOR_GREEN" "EQUAL " "$SOURCE" "$TARGET"
}

is_same_structure()
{
	local SOURCE="$1"
	local TARGET="$2"

	if [[ ! -e "$TARGET" ]] || ! diff -qrr "$SOURCE" "$TARGET" >/dev/null 2>&1;
	then
		pprint "$_COLOR_RED" "EQUAL " "$SOURCE" "$TARGET"
		EXIT_CODE=1
		return 1
	fi

	pprint "$_COLOR_GREEN" "EQUAL " "$SOURCE" "$TARGET"
}

# output header
pprint "$_COLOR_NEUTRAL" "STATUS" "SOURCE" "TARGET"

###	ACTION			SOURCE											TARGET

# refind
has_same_content	"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"
has_same_content	"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"

# kernel presets
has_same_content	"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"
has_same_content	"$CONFIGS_DIR/KernelPresets/linux-zen.preset"	"/etc/mkinitcpio.d/linux-zen.preset"

# oh my zsh
is_linked			"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"
for config in		"$CONFIGS_DIR/OhMyZsh/"*;
do
	is_linked		"$config"										"$HOME/.oh-my-zsh/custom/$(basename "$config")"
done

# git
is_linked			"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"

# nvim
is_linked			"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"

# vim
is_linked			"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"

# nano
is_linked			"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"

# samba
is_linked			"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"
is_linked			"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"

# nginx
is_linked			"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"
is_linked			"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"

# hyprland
is_linked			"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"

# waybar
is_linked			"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"

# mimeapps list
is_linked			"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"

# mango hud
is_linked			"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"

exit "$EXIT_CODE"
