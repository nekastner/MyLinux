# ADD PATHS TO $PATH

source "$ZSH/custom/colors.zsh"

SCRIPT_PATH="$ZSH/custom/$(basename "$0")"
if ! [[ -L "$SCRIPT_PATH" ]];then
	printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" "ERROR ==> '$SCRIPT_PATH' is not a link!"
	return 1
fi

SCRIPT_DIR_REALPATH="$(dirname "$(realpath "$SCRIPT_PATH")")"
if ! [[ -d "$SCRIPT_DIR_REALPATH" ]];then
	printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" "ERROR ==> '$SCRIPT_DIR_REALPATH' is not adirectory!"
	return 1
fi

CONFIGS_ROOT_DIR="$(git -C "$SCRIPT_DIR_REALPATH" rev-parse --show-toplevel)"
if ! [[ $? -eq 0 ]]; then
	printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" "ERROR ==> '$SCRIPT_DIR_REALPATH' is not a git repo!"
	return 1
fi

PATHS_TO_ADD_TO_PATH=(
	"$CONFIGS_ROOT_DIR/Scripts/Arch"
	"$CONFIGS_ROOT_DIR/Scripts/General"
)
for path_to_add_to_path in "${PATHS_TO_ADD_TO_PATH[@]}"; do
	if [[ ":${PATH}:" == *":${path_to_add_to_path}:"* ]]; then continue; fi
	export PATH="$PATH:$path_to_add_to_path"
done
