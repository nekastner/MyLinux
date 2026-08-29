alias waybar-reload="pkill -USR2 waybar"

to_clipboard()
{
	cat $1 | wl-copy
}
