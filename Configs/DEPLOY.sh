#!/bin/bash
set -euo pipefail

CONFIGS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo -v

link() {

	local SOURCE=$1
	local TARGET=$2
	local TARGET_DIR=$(dirname "$TARGET")
	local MODE=$3

	local EXEC=""
	if [[ ! -w "$TARGET_DIR" ]] || { [[ -e "$TARGET" || -L "$TARGET" ]] && [[ ! -w "$TARGET" ]]; }; then
		[[ "$EUID" -ne 0 ]] && EXEC="sudo"
	fi

	if [[ -e "$TARGET" || -L "$TARGET" ]]; then
		read -rp "Overwrite '$TARGET'? [y/N] " user_confirmation < /dev/tty
		if [[ ! "$user_confirmation" =~ ^[yY]$ ]]; then
			echo "Aborted overwriting '$TARGET'."
			return 0
		fi	
		echo "'$TARGET' will become overwritten..."
		$EXEC rm -rf "$TARGET"
	fi

	$EXEC mkdir -p "$TARGET_DIR"

	if [[ "$MODE" == 'ln' ]]; then
		$EXEC ln -sf "$SOURCE" "$TARGET"
		echo "Linked '$SOURCE' to '$TARGET'."
	elif [[ "$MODE" == 'cp' ]]; then
		$EXEC cp -rf "$SOURCE" "$TARGET"
		echo "Copied '$SOURCE' to '$TARGET'."
	fi

	if [[ "$TARGET" =~ ^/(etc|usr|boot)/ ]]; then
		$EXEC chown -R root:root "$TARGET"
	fi
}

#				SOURCE											TARGET									MODE
link			"$CONFIGS_DIR/OhMyZsh/.zshrc"					"$HOME/.zshrc"							'ln'
for config in	"$CONFIGS_DIR/OhMyZsh/"*; do
    [[ -e "$config" ]] || continue
    name=$(basename "$config")
	link		"$config"										"$HOME/.oh-my-zsh/custom/$name"			'ln'
done
link			"$CONFIGS_DIR/Nvim"								"$HOME/.config/nvim"					'ln'
link			"$CONFIGS_DIR/Vim/.vimrc"						"$HOME/.vimrc"							'ln'
link			"$CONFIGS_DIR/Git/.gitconfig"					"$HOME/.gitconfig"						'ln'
link			"$CONFIGS_DIR/Nano/.nanorc"						"$HOME/.nanorc"							'ln'
link			"$CONFIGS_DIR/Hyprland/hypr"					"$HOME/.config/hypr"					'ln'
link			"$CONFIGS_DIR/Hyprland/waybar"					"$HOME/.config/waybar"					'ln'
link			"$CONFIGS_DIR/MangoHud/Mangohud"				"$HOME/.config/Mangohud"				'ln'
link			"$CONFIGS_DIR/MimeAppList/mimeapps.list"		"$HOME/.config/mimeapps.list"			'ln'
link			"$CONFIGS_DIR/Refind/refind.conf"				"/boot/EFI/refind/refind.conf"			'cp'
link			"$CONFIGS_DIR/Refind/background.png"			"/boot/EFI/refind/background.png"		'cp'
link			"$CONFIGS_DIR/KernelPresets/linux.preset"		"/etc/mkinitcpio.d/linux.preset"		'cp'
link			"$CONFIGS_DIR/KernelPresets/zen-linux.preset"	"/etc/mkinitcpio.d/zen-linux.preset"	'cp'
link			"$CONFIGS_DIR/Sddm/sddm.conf"					"/etc/sddm.conf"						'ln'
link			"$CONFIGS_DIR/Sddm/themes"						"/usr/share/sddm/themes"				'ln'
link			"$CONFIGS_DIR/Samba/smb.conf"					"/etc/samba/smb.conf"					'ln'
link			"$CONFIGS_DIR/Samba/user_specific"				"/etc/samba/user_specific"				'ln'
link			"$CONFIGS_DIR/Nginx/nginx.conf"					"/etc/nginx/nginx.conf"					'ln'
link			"$CONFIGS_DIR/Nginx/sites-available"			"/etc/nginx/sites-available"			'ln'

exit 0
