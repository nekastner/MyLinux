source "$ZSH/custom/colors.zsh"

alias net-st='nmcli general status'
alias net-ls='nmcli device status'
alias net-dev='nmcli device'
alias net-con-ls='nmcli connection show'
alias net-con-active='nmcli connection show --active'

alias net-on='nmcli networking on'
alias net-off='nmcli networking off'

alias net-con-on='net_con_on'
function net_con_on
{
	if (( $# < 1 || $# > 2 )); then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf '%s\n' 'Parameters: <connection> [ifname]'
		return 1
	fi

	local connection="$1"
	local ifname="${2:-}"

	if [[ -n "$ifname" ]]; then
		nmcli connection up "$connection" ifname "$ifname"
	else
		nmcli connection up "$connection"
	fi
}

alias net-con-off='net_con_off'
function net_con_off
{
	if (( $# != 1 )); then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf '%s\n' 'Parameters: <connection>'
		return 1
	fi

	nmcli connection down "$1"
}

alias wifi-on='nmcli radio wifi on'
alias wifi-off='nmcli radio wifi off'

alias wifi-ls='nmcli device wifi'

alias wifi-st='wifi_st'
function wifi_st
{
	if (( $# != 1 )); then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf '%s\n' 'Parameters: <ifname>'
		return 1
	fi

	local ifname="$1"
	
	nmcli device wifi show ifname "$ifname"
	nmcli device show "$ifname"
}

alias wifi-con='wifi_con'
function wifi_con
{
	if (( $# < 1 )) || (( $# > 2 )); then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf '%s\n' 'Parameters: <ssid> [ifname]'
		return 1
	fi

	local ssid="$1"
	local ifname="${2:-}"

	if [[ -n "$ifname" ]]; then
		nmcli --ask device wifi connect "$ssid" ifname "$ifname"
	else
		nmcli --ask device wifi connect "$ssid"
	fi
}

alias net-dev-on='net_dev_on'
function net_dev_on
{
	if (( $# != 1 )); then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf '%s\n' 'Parameters: <ifname>'
		return 1
	fi

	local device_name="$1"

	nmcli device up "$device_name"
}

alias net-dev-off='net_dev_off'
function net_dev_off
{
	if (( $# != 1 )); then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf '%s\n' 'Parameters: <ifname>'
		return 1
	fi

	local device_name="$1"

	nmcli device down "$device_name"
}
