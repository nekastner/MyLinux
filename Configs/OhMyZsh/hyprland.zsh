alias waybar-reload="pkill -USR2 waybar"

alias to-clipboard='to_clipboard'
to_clipboard()
{
	cat $1 | wl-copy
}
