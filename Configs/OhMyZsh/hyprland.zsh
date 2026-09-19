alias waybar-reload="pkill -USR2 waybar"

alias rotate-monitor='rotate_monitor'
rotate_monitor()
{
	if (( $# != 2 ));
	then
		echo "ERROR ==> Wrong usage!"
		echo "Parameters: <monitor name> <rotation>"
		return 1
	fi

	local name="$1"
	local rotation="$2"

	hyprctl keyword monitor "${name},preferred,auto,1,transform,${rotation}"
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
