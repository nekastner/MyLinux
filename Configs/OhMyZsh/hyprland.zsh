source "$ZSH/custom/colors.zsh"

alias quit-hyprland='command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'

alias start-waybar='start_waybar'
function start_waybar
{
	local CONFIG_PATH="$HOME/.config/waybar/host_specific/$HOST.jsonc"
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
function hyprland_exec
{
	local command="$*"
	command="${command//\\/\\\\}"
	command="${command//\"/\\\"}"
	hyprctl dispatch "hl.dsp.exec_cmd(\"$command\")"
}

alias kitty-ssh='kitty +kitten ssh'
