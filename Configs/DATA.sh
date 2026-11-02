# LOCATIONS
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIGS_DIR="$SCRIPT_DIR"

# SOURCES AND TARGETS LIST
declare -A SOURCES_TARGETS_LIST=()
declare -a SOURCES_ORDER=()

function sources_targets_add_entry
{
	local key="$1" value="$2"

	if ! [[ -v SOURCES_TARGETS_LIST["$key"] ]]; then
		SOURCES_ORDER+=("$key")
	fi

	SOURCES_TARGETS_LIST["$key"]="$value"
}

# refind
sources_targets_add_entry "${CONFIGS_DIR}/Refind/refind.conf" "/boot/EFI/refind/refind.conf"
sources_targets_add_entry "${CONFIGS_DIR}/Refind/background.png" "/boot/EFI/refind/background.png"

# kernel
sources_targets_add_entry "${CONFIGS_DIR}/Kernel-cmdline/cmdline" "/etc/kernel/cmdline"
shopt -s nullglob
for config in "$CONFIGS_DIR"/KernelPresets/*; do
	config_name="$(basename "$config")"
	sources_targets_add_entry "$config" "/etc/mkinitcpio.d/$config_name"
done
shopt -u nullglob

# locale
shopt -s nullglob
for config in "$CONFIGS_DIR"/Locale/*; do
	config_name="$(basename "$config")"
	sources_targets_add_entry "$config" "/usr/share/i18n/locales/$config_name"
done
shopt -u nullglob

# bash
sources_targets_add_entry  "${CONFIGS_DIR}/Bash/.bashrc" "$HOME/.bashrc"

# oh my zsh
sources_targets_add_entry "${CONFIGS_DIR}/OhMyZsh/.zshrc" "$HOME/.zshrc"
shopt -s nullglob
for config in "$CONFIGS_DIR"/OhMyZsh/*; do
	config_name="$(basename "$config")"
	sources_targets_add_entry "$config" "$HOME/.oh-my-zsh/custom/$config_name"
done
shopt -u nullglob

# git
sources_targets_add_entry "${CONFIGS_DIR}/Git/.gitconfig" "$HOME/.gitconfig"

# nvim
sources_targets_add_entry "${CONFIGS_DIR}/Nvim" "$HOME/.config/nvim"

# vim
sources_targets_add_entry "${CONFIGS_DIR}/Vim/.vimrc" "$HOME/.vimrc"

# nano
sources_targets_add_entry "${CONFIGS_DIR}/Nano/.nanorc" "$HOME/.nanorc"

# clang format
sources_targets_add_entry "${CONFIGS_DIR}/Clang/.clang-format" "$HOME/.clang-format"

# ruff
sources_targets_add_entry "${CONFIGS_DIR}/Ruff" "$HOME/.config/ruff"

# samba
sources_targets_add_entry "${CONFIGS_DIR}/Samba/smb.conf" "/etc/samba/smb.conf"
sources_targets_add_entry "${CONFIGS_DIR}/Samba/user_specific" "/etc/samba/user_specific"

# nginx
sources_targets_add_entry "${CONFIGS_DIR}/Nginx/nginx.conf" "/etc/nginx/nginx.conf"
sources_targets_add_entry "${CONFIGS_DIR}/Nginx/sites-available" "/etc/nginx/sites-available"

# hyprland
sources_targets_add_entry "${CONFIGS_DIR}/Hyprland" "$HOME/.config/hypr"
sources_targets_add_entry "${CONFIGS_DIR}/Waybar" "$HOME/.config/waybar"

# mimeapps list
sources_targets_add_entry "${CONFIGS_DIR}/MimeAppsList/mimeapps.list" "$HOME/.config/mimeapps.list"

# mangohud
sources_targets_add_entry "${CONFIGS_DIR}/MangoHud" "$HOME/.config/MangoHud"
