#!/bin/bash

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

GREEN='\033[0;32m'
RED='\033[0;31m'
NEUTRAL='\033[0m'

pprint()
{
	local STATUS_COLOR=$1
	local STATUS_TEXT=$2
	local SOURCE=$3
	local TARGET=$4

	printf "[ ${STATUS_COLOR}${STATUS_TEXT}${NEUTRAL} ] %-50s -> %s\n" "$TARGET" "$SOURCE"
}

is_linked()
{
	local SOURCE=$1
	local TARGET=$2

	if [[ ! -e "$TARGET" || ! -L "$TARGET" || ! "$(realpath "$TARGET")" = "$SOURCE" ]];
	then
		pprint "$RED" "LINKED" "$SOURCE" "$TARGET"
		return 1
	fi

	pprint "$GREEN" "LINKED" "$SOURCE" "$TARGET"
	return 0

}

has_same_content()
{
	local SOURCE=$1
	local TARGET=$2

	if [[ ! -e "$TARGET" ]] || ! cmp --silent "$SOURCE" "$TARGET";
	then
		pprint "$RED" "EQUAL " "$SOURCE" "$TARGET"
		return 1
	fi
	pprint "$GREEN" "EQUAL " "$SOURCE" "$TARGET"
	return 0
}

is_same_structure()
{
	local SOURCE=$1
	local TARGET=$2

	if [[ ! -e "$TARGET" ]] || ! diff -qrr "$SOURCE" "$TARGET" >/dev/null 2>&1;
	then
		pprint "$RED" "EQUAL " "$SOURCE" "$TARGET"
		return 1
	fi
	pprint "$GREEN" "EQUAL " "$SOURCE" "$TARGET"
	return 0
}

# output header
pprint "$NEUTRAL" "STATUS" "SOURCE" "TARGET"

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

# sddm
is_linked			"$CONFIGS_DIR/Sddm/sddm.conf"					"/etc/sddm.conf"
is_same_structure	"$CONFIGS_DIR/Sddm/themes"						"/usr/share/sddm/themes"

# hyprland
is_linked			"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"

# waybar
is_linked			"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"

# mimeapps list
is_linked			"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"

# mango hud
is_linked			"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"
