#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIGS_DIR="$SCRIPT_DIR"

_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_GREEN='\033[0;32m'
_COLOR_YELLOW='\033[0;33m'

# ensure root rights are given
sudo -v

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

#				SOURCE											TARGET
deploy			"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"
deploy			"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"
deploy			"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"
deploy			"$CONFIGS_DIR/KernelPresets/linux-zen.preset"	"/etc/mkinitcpio.d/linux-zen.preset"
deploy			"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"
for config in	"$CONFIGS_DIR/OhMyZsh/"*;
do
	[[ -e "$config" ]] || continue
	config_name=$(basename "$config")
	deploy		"$config"										"$HOME/.oh-my-zsh/custom/$config_name"
done
deploy			"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"
deploy			"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"
deploy			"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"
deploy			"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"
deploy			"$CONFIGS_DIR/Clang/.clang-format"				"$HOME/.clang-format"
deploy			"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"
deploy			"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"
deploy			"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"
deploy			"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"
deploy			"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"
deploy			"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"
deploy			"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"
deploy			"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"
