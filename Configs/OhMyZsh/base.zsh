alias sudo='sudo '
unalias mkdir 2> /dev/null
unalias cp 2> /dev/null
unalias mv 2> /dev/null

alias src="source $HOME/.zshrc"
alias clr='clear'
alias now='date +"%Y/%m/%d %H:%M:%S%n week: %V | day: %u "'

alias py='python'
alias pip='python -m pip'
alias py-venv="python -m venv"

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '\e[3~' delete-char
bindkey '\e[3;5~' kill-word

_COLOR_GREEN='\033[0;32m'
_COLOR_RED='\033[0;31m'
_COLOR_NEUTRAL='\033[0m'

vpy()
{
	local venv_dir="$1"
	local python_args=("${@:2}")

	[[ -x "$venv_dir/bin/python" ]] || {
		printf "${_COLOR_RED}Python venv not found: $venv_dir/bin/python${_COLOR_NEUTRAL}"
		return 1
	}

	"$venv_dir/bin/python" "${python_args[@]}"
}

vpip()
{
	local venv_dir="$1"
	local pip_args=("${@:2}")

	vpy "$venv_dir" -m pip "${pip_args[@]}"
}

mnt_crpt()
{
	local device=$1
	local mapper=$2
	local mountpoint=$3

	[[ $# == 3 ]] || {
		printf "${_COLOR_RED}Usage: mnt-crpt <device> <mapper> <mountpoint>${_COLOR_NEUTRAL}"
		return 1
	}

	sudo cryptsetup open "$device" "$mapper" || return

	sudo mount "$mapper" "$mountpoint" || {
		sudo cryptsetup close "$mapper"
		return 1
	}

	printf "Mounted '$device' ('$mapper') to '$mountpoint'."
}
