#!/bin/bash

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_GREEN='\033[0;32m'
_COLOR_YELLOW='\033[0;32m'

sudo -v

deploy()
{
	local SOURCE="$1"
	local TARGET="$2"
	local TARGET_DIR="$(dirname "$TARGET")"
	local MODE="$3"
	local USE_SUDO=$4

	local EXEC_PREFIX=''
	if (( USE_SUDO == 1));
	then
		EXEC_PREFIX='sudo'
	fi

	# if target already exists
	if [[ -e "$TARGET" ]];
	then
		# if target is linked to source
		if [[ "$MODE" == 'ln' ]];
		then
			if [[ -L "$TARGET" && "$(realpath "$TARGET")" = "$SOURCE" ]];
			then
				printf "${_COLOR_GREEN}'$TARGET' already linked to '$SOURCE'!${_COLOR_NEUTRAL}\n"
				return 0;
			fi
		# if target is already equal to source
		elif [[ "$MODE" == 'cp' ]];
		then
			if { [[ ! -d "$TARGET" ]] && cmp --silent "$SOURCE" "$TARGET"; } || { [[ -d "$TARGET" ]] && diff -qrr "$SOURCE" "$TARGET" >/dev/null 2>&1; };
			then
				printf "${_COLOR_GREEN}'$TARGET' already equal to '$SOURCE'!${_COLOR_NEUTRAL}\n"
				return 0;
			fi
		# if target is not linked or equal
		else
			printf "${_COLOR_YELLOW}WARNING ==> '$TARGET' already exists!${_COLOR_NEUTRAL}\n"
			read -rp "Overwrite '$TARGET' with '$SOURCE'? [y/N] " user_confirmation < /dev/tty
			# if user does not want to overwrite existing config
			if [[ ! "$user_confirmation" =~ ^[yY]$ ]];
			then
				printf "${_COLOR_RED}Aborted overwriting '$TARGET' by '$SOURCE'.${_COLOR_NEUTRAL}\n"
				return 1
			fi
			$EXEC_PREFIX rm -rf "$TARGET"
		fi
	# if target does not already exist
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

	# ensure, target dir exists
	$EXEC_PREFIX mkdir -p "$TARGET_DIR"

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

	if [[ "$EXEC_PREFIX" == 'sudo' ]];
	then
		$EXEC_PREFIX chown -R root:root "$TARGET"
		printf "${_COLOR_YELLOW}Changed ownership of '$TARGET' to 'root:root'!${_COLOR_NEUTRAL}\n"
	fi
}

#				SOURCE											TARGET									MODE
deploy			"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"			'cp' 1
deploy			"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"		'cp' 1
deploy			"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"		'cp' 1
deploy			"$CONFIGS_DIR/KernelPresets/linux-zen.preset"	"/etc/mkinitcpio.d/linux-zen.preset"	'cp' 1
deploy			"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"							'ln' 0
for config in	"$CONFIGS_DIR/OhMyZsh/"*;
do
    [[ -e "$config" ]] || continue
    config_name=$(basename "$config")
	deploy		"$config"										"$HOME/.oh-my-zsh/custom/$config_name"	'ln' 0
done
deploy			"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"						'ln' 0
deploy			"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"					'ln' 0
deploy			"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"							'ln' 0
deploy			"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"							'ln' 0
deploy			"$CONFIGS_DIR/Clang/.clang-format"				"$HOME/.clang-format"					'ln' 0
deploy			"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"					'ln' 1
deploy			"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"				'ln' 1
deploy			"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"					'ln' 1
deploy			"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"			'ln' 1
deploy			"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"					'ln' 0
deploy			"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"					'ln' 0
deploy			"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"			'ln' 0
deploy			"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"				'ln' 0
