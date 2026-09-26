alias quit-hyprland='command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'

alias start-waybar='hyprland_exec waybar'
alias stop-waybar='pkill waybar'
alias reload-waybar='pkill -SIGUSR2 waybar'

alias start-hyprsenset='hyprland_exec hyprsunset'
alias stop-hyprsunset='pkill hyprsunset'

alias start-hyprpaper='hyprland_exec hyprpaper'
alias stop-hyprpaper='pkill hyprpaper'

alias hyprland-exec='hyprland_exec'
hyprland_exec()
{
	local command="$@"
	hyprctl dispatch "hl.dsp.exec_cmd(\"$command\")"
}

alias to-clipboard='to_clipboard'
to_clipboard()
{
	if (( $# != 1 ));
	then
		echo "ERROR ==> Wrong usage!"
		echo "Parameters: <file name>"
		return 1
	fi

	local file_name="$1"

	if ! [[ -e "$file_name" && -r "$file_name" ]];
	then
		echo "'$file_name' does not exist or has no read permissions!"
		return 1
	fi

	wl-copy < "$file_name"
}
