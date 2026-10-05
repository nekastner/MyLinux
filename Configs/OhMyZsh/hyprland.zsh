source "$ZSH/custom/colors.zsh"

alias quit-hyprland='command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'

alias start-waybar='start_waybar'
start_waybar()
{
	local CONFIG_PATH="$HOME/.config/waybar/$HOST.jsonc"
	if [[ -e "$CONFIG_PATH" ]]; then
		hyprland_exec "waybar --config $CONFIG_PATH"
	else
		hyprland_exec 'waybar'
	fi
}
alias stop-waybar='pkill waybar'
alias reload-waybar='pkill -SIGUSR2 waybar'

alias start-hyprsenset='hyprland_exec hyprsunset'
alias stop-hyprsunset='pkill hyprsunset'

alias start-hyprpaper='hyprland_exec hyprpaper'
alias stop-hyprpaper='pkill hyprpaper'

alias hyprland-exec='hyprland_exec'
hyprland_exec()
{
	local command="$*"
	command="${command//\\/\\\\}"
	command="${command//\"/\\\"}"
	hyprctl dispatch "hl.dsp.exec_cmd(\"$command\")"
}

alias to-clipboard='to_clipboard'
to_clipboard()
{
	if (( $# != 1 )); then
		printf "${COLOR_RED}ERROR ==> Wrong usage!${COLOR_NEUTRAL}"
		printf "Parameters: <file name>"
		return 1
	fi

	local file_name="$1"

	if ! [[ -e "$file_name" && -r "$file_name" ]]; then
		printf "${COLOR_RED}'$file_name' does not exist or has no read permissions!${COLOR_NEUTRAL}"
		return 1
	fi

	wl-copy < "$file_name"
}
