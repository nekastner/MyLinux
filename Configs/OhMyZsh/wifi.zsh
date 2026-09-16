alias wifi-ls='nmcli device wifi'

alias wifi-st='wifi_st'
wifi_st()
{
	if (( $# != 1 ));
	then
		echo "ERROR ==> Wrong usage!" >&2
		echo "Parameters: <ifname>"
		return 1
	fi

	local ifname=$1
	
	nmcli device wifi show ifname "$ifname"
	nmcli device show "$ifname"
}

alias wifi-con='wifi_con'
wifi_con()
{
	if (( $# != 2 ));
	then
		echo "ERROR ==> Wrong usage!" >&2
		echo "Parameters: <ifname> <ssid>"
		return 1
	fi

	local ifname=$1
	local ssid=$2

	sudo nmcli --ask device wifi connect "$ssid" ifname "$ifname"
}
