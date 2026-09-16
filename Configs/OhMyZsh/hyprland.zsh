alias waybar-reload="pkill -USR2 waybar"

alias to-clipboard='to_clipboard'
to_clipboard()
{
	if (( $# != 1 ));
	then
		echo "ERROR ==> Wrong usage!" >&2
		echo "Parameters: <file name>"
		return 1
	fi

	local file_name=$1

	if ! [[ -e "$file_name" && -r "$file_name" ]];
	then
		echo "'$file_name' does not exist or has no read permissions!" >&2
		return 1
	fi

	wl-copy < "$file_name"
}
