alias quit-hyprland='command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'

alias stop-hyprsunset='pkill hyprsunset'
alias start-hyprsenset='hyprctl dispatch "hl.dsp.exec_cmd(\"hyprsunset\")"'

alias stop-hyprpaper='pkill hyprpaper'
alias start-hyprpaper='hyprctl dispatch "hl.dsp.exec_cmd(\"hyprpaper\")"'

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
