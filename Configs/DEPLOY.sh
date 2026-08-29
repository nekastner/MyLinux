#!/bin/bash

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

GREEN='\033[0;32m'
RED='\033[0;31m'
NEUTRAL='\033[0m'

sudo -v

link() {

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
			printf "${RED}Aborted overwriting '$TARGET' by '$SOURCE'.${NEUTRAL}\n"
			return 1
		fi	
		printf "'$TARGET' will become overwritten...\n"
		$EXEC rm -rf "$TARGET"
	else
		if [[ "$MODE" == 'ln' ]];
		then
			read -rp "Link '$SOURCE' to '$TARGET'? [y/N] " user_confirmation < /dev/tty
			if [[ ! "$user_confirmation" =~	^[yY]$ ]];
			then
				printf "${RED}Aborted linking '$SOURCE' to '$TARGET'.${NEUTRAL}\n"
				return 1
			fi
		elif [[ "$MODE" == 'cp' ]];
		then
			read -rp "Copy '$SOURCE' to '$TARGET'? [y/N] " user_confirmation < /dev/tty
			if [[ ! "$user_confirmation" =~	^[yY]$ ]];
			then
				printf "${RED}Aborted copying '$SOURCE' to '$TARGET'.${NEUTRAL}\n"
				return 1
			fi
		fi
	fi

	$EXEC mkdir -p "$TARGET_DIR"

	if [[ "$MODE" == 'ln' ]];
	then
		$EXEC ln -sf "$SOURCE" "$TARGET"
		printf "${GREEN}Linked '$SOURCE' to '$TARGET'.${NEUTRAL}\n"
	elif [[ "$MODE" == 'cp' ]];
	then
		$EXEC cp -rf "$SOURCE" "$TARGET"
		printf "${GREEN}Copied '$SOURCE' to '$TARGET'.${NEUTRAL}\n"
	fi

	if [[ ! "$TARGET" =~ ^/home/ ]];
	then
		$EXEC chown -R root:root "$TARGET"
	fi

	return 0
}

#				SOURCE											TARGET									MODE
link			"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"			'cp'
link			"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"		'cp'
link			"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"		'cp'
link			"$CONFIGS_DIR/KernelPresets/linux-zen.preset"	"/etc/mkinitcpio.d/linux-zen.preset"	'cp'
link			"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"							'ln'
for config in	"$CONFIGS_DIR/OhMyZsh/"*;
do
    [[ -e "$config" ]] || continue
    name=$(basename "$config")
	link		"$config"										"$HOME/.oh-my-zsh/custom/$name"			'ln'
done
link			"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"						'ln'
link			"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"					'ln'
link			"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"							'ln'
link			"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"							'ln'
link			"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"					'ln'
link			"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"				'ln'
link			"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"					'ln'
link			"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"			'ln'
link			"$CONFIGS_DIR/Sddm/sddm.conf"					"/etc/sddm.conf"						'ln'
link			"$CONFIGS_DIR/Sddm/themes"						"/usr/share/sddm/themes"				'cp'
link			"$CONFIGS_DIR/Hyprland"							"$HOME/.config/hypr"					'ln'
link			"$CONFIGS_DIR/Waybar"							"$HOME/.config/waybar"					'ln'
link			"$CONFIGS_DIR/MimeAppsList/mimeapps.list"		"$HOME/.config/mimeapps.list"			'ln'
link			"$CONFIGS_DIR/MangoHud"							"$HOME/.config/MangoHud"				'ln'

exit 0
