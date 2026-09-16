alias wifi-ls='nmcli device wifi'

alias wifi-st='wifi_st'
wifi_st()
{
	local ifname=$1

	if [[ $# != 1 ]];
	then
		echo "ERROR ==> Wrong usage." >&2
		echo "Parameters: <ifname>"
		return 1
	fi
	
	nmcli device wifi show ifname "$ifname"
	nmcli device show "$ifname"
	return 0
}

alias wifi-con='wifi_con'
wifi_con()
{
	local ifname=$1
	lcoal ssid=$2

	if [[ $# != 2 ]];
	then
		echo "ERROR ==> Wrong usage." >&2
		echo "Parameters: <ifname> <ssid>"
		return 1
	fi

	sudo nmcli --ask device wifi connect "$ssid" ifname "ifname"
	return 0
}
