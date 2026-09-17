#!/bin/bash

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_GREEN='\033[0;32m'
_COLOR_YELLOW='\033[0;32m'

sudo -v

deploy() {

	local SOURCE=$1
	local TARGET=$2
	local TARGET_DIR=$(dirname "$TARGET")
	local MODE=$3

	if [[ -e "$TARGET" ]];
	then
		if [[ "$MODE" == 'ln' ]];
		then
			# if target already linked to source
			if [[ -L "$TARGET" && "$(realpath "$TARGET")" = "$SOURCE" ]];
			then
				return 0;
			fi
		elif [[ "$MODE" == 'cp' ]];
		then
			# if target is already equal to source
			if [[ ! -d "$TARGET" ]] && cmp --silent "$SOURCE" "$TARGET";
			then
				return 0;
			elif [[ -d "$TARGET" ]] && diff -qrr "$SOURCE" "$TARGET" >/dev/null 2>&1;
			then
				return 0;
			fi
		fi
	fi

	local EXEC=""
	if [[ ! -w "$TARGET_DIR" ]] || { [[ -e "$TARGET" || -L "$TARGET" ]] && [[ ! -w "$TARGET" ]]; };
	then
		[[ "$EUID" -ne 0 ]] && EXEC="sudo"
	fi

	if [[ -e "$TARGET" ]];
	then
		read -rp "Overwrite '$TARGET' by '$SOURCE'? [y/N] " user_confirmation < /dev/tty
		if [[ ! "$user_confirmation" =~ ^[yY]$ ]];
		then
			printf "${_COLOR_RED}Aborted overwriting '$TARGET' by '$SOURCE'.${_COLOR_NEUTRAL}\n"
			return 1
		fi	
		printf "${_COLOR_YELLOW}'$TARGET' will become overwritten...${_COLOR_NEUTRAL}\n"
		$EXEC rm -rf "$TARGET"
	else
		if [[ "$MODE" == 'ln' ]];
		then
			read -rp "Link '$SOURCE' to '$TARGET'? [y/N] " user_confirmation < /dev/tty
			if [[ ! "$user_confirmation" =~	^[yY]$ ]];
			then
				printf "${_COLOR_RED}Aborted linking '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
				return 1
			fi
		elif [[ "$MODE" == 'cp' ]];
		then
			read -rp "Copy '$SOURCE' to '$TARGET'? [y/N] " user_confirmation < /dev/tty
			if [[ ! "$user_confirmation" =~	^[yY]$ ]];
			then
				printf "${_COLOR_RED}Aborted copying '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
				return 1
			fi
		fi
	fi

	$EXEC mkdir -p "$TARGET_DIR"

	if [[ "$MODE" == 'ln' ]];
	then
		$EXEC ln -sf "$SOURCE" "$TARGET"
		printf "${_COLOR_GREEN}Linked '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
	elif [[ "$MODE" == 'cp' ]];
	then
		$EXEC cp -rf "$SOURCE" "$TARGET"
		printf "${_COLOR_GREEN}Copied '$SOURCE' to '$TARGET'.${_COLOR_NEUTRAL}\n"
	fi

	if [[ ! "$TARGET" =~ ^/home/ ]];
	then
		$EXEC chown -R root:root "$TARGET"
	fi

	return 0
}

#				SOURCE											TARGET									MODE
deploy			"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"			'cp'
deploy			"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"		'cp'
deploy			"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"		'cp'
deploy			"$CONFIGS_DIR/KernelPresets/linux-zen.preset"	"/etc/mkinitcpio.d/linux-zen.preset"	'cp'
deploy			"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"							'ln'
for config in	"$CONFIGS_DIR/OhMyZsh/"*;
do
    [[ -e "$config" ]] || continue
    config_name=$(basename "$config")
	deploy		"$config"										"$HOME/.oh-my-zsh/custom/$config_name"			'ln'
done
deploy			"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"						'ln'
deploy			"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"					'ln'
deploy			"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"							'ln'
deploy			"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"							'ln'
deploy			"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"					'ln'
deploy			"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"				'ln'
deploy			"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"					'ln'
deploy			"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"			'ln'
deploy			"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"					'ln'
deploy			"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"					'ln'
deploy			"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"			'ln'
deploy			"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"				'ln'
