_COLOR_NEUTRAL='\033[0m'
_COLOR_RED='\033[0;31m'
_COLOR_GREEN='\033[0;32m'
_COLOR_YELLOW='\033[0;33m'

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIGS_DIR="$SCRIPT_DIR"

declare -A SOURCES_TARGETS_LIST=(
	["${CONFIGS_DIR}/Refind/refind.conf"]="/boot/EFI/refind/refind.conf"
	["${CONFIGS_DIR}/Refind/background.png"]="/boot/EFI/refind/background.png"
	["${CONFIGS_DIR}/KernelPresets/linux.preset"]="/etc/mkinitcpio.d/linux.preset"
	["${CONFIGS_DIR}/KernelPresets/linux-zen.preset"]="/etc/mkinitcpio.d/linux-zen.preset"
	["${CONFIGS_DIR}/OhMyZsh/.zshrc"]="$HOME/.zshrc"
	["${CONFIGS_DIR}/Git/.gitconfig"]="$HOME/.gitconfig"
	["${CONFIGS_DIR}/Nvim"]="$HOME/.config/nvim"
	["${CONFIGS_DIR}/Vim/.vimrc"]="$HOME/.vimrc"
	["${CONFIGS_DIR}/Nano/.nanorc"]="$HOME/.nanorc"
	["${CONFIGS_DIR}/Clang/.clang-format"]="$HOME/.clang-format"
	["${CONFIGS_DIR}/Samba/smb.conf"]="/etc/samba/smb.conf"
	["${CONFIGS_DIR}/Samba/user_specific"]="/etc/samba/user_specific"
	["${CONFIGS_DIR}/Nginx/nginx.conf"]="/etc/nginx/nginx.conf"
	["${CONFIGS_DIR}/Nginx/sites-available"]="/etc/nginx/sites-available"
	["${CONFIGS_DIR}/Hyprland"]="$HOME/.config/hypr"
	["${CONFIGS_DIR}/Waybar"]="$HOME/.config/waybar"
	["${CONFIGS_DIR}/MimeAppsList/mimeapps.list"]="$HOME/.config/mimeapps.list"
	["${CONFIGS_DIR}/MangoHud"]="$HOME/.config/MangoHud"
)

for config in "$CONFIGS_DIR/OhMyZsh/"*;
do
	config_name="$(basename "$config")"
	SOURCES_TARGETS_LIST["$config"]="$HOME/.oh-my-zsh/custom/$config_name"
done
