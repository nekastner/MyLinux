# LOCATIONS
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIGS_DIR="$SCRIPT_DIR"

# SOURCES AND TARGETS LIST
declare -A SOURCES_TARGETS_LIST=()
# refind
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Refind/refind.conf"]="/boot/EFI/refind/refind.conf"
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Refind/background.png"]="/boot/EFI/refind/background.png"
# kernel
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/KernelPresets/linux.preset"]="/etc/mkinitcpio.d/linux.preset"
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/KernelPresets/linux-zen.preset"]="/etc/mkinitcpio.d/linux-zen.preset"
# oh my zsh
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/OhMyZsh/.zshrc"]="$HOME/.zshrc"
shopt -s dotglob nullglob
for config in "$CONFIGS_DIR/OhMyZsh/"*; do
	config_name="$(basename "$config")"
	if [[ "$config_name" == '.zshrc' ]]; then continue; fi
	SOURCES_TARGETS_LIST["$config"]="$HOME/.oh-my-zsh/custom/$config_name"
done
shopt -u dotglob nullglob
# git
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Git/.gitconfig"]="$HOME/.gitconfig"
# nvim
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Nvim"]="$HOME/.config/nvim"
# vim
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Vim/.vimrc"]="$HOME/.vimrc"
# nano
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Nano/.nanorc"]="$HOME/.nanorc"
# clang format
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Clang/.clang-format"]="$HOME/.clang-format"
# ruff
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Ruff"]="$HOME/.config/ruff"
# samba
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Samba/smb.conf"]="/etc/samba/smb.conf"
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Samba/user_specific"]="/etc/samba/user_specific"
# nginx
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Nginx/nginx.conf"]="/etc/nginx/nginx.conf"
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Nginx/sites-available"]="/etc/nginx/sites-available"
# hyprland
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Hyprland"]="$HOME/.config/hypr"
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/Waybar"]="$HOME/.config/waybar"
# mimeapps list
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/MimeAppsList/mimeapps.list"]="$HOME/.config/mimeapps.list"
# mangohud
SOURCES_TARGETS_LIST["${CONFIGS_DIR}/MangoHud"]="$HOME/.config/MangoHud"
