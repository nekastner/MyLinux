alias sudo='sudo '
unalias mkdir 2> /dev/null
unalias cp 2> /dev/null
unalias mv 2> /dev/null

alias src="source $HOME/.zshrc"
alias clr='clear'
alias now='date +"%Y/%m/%d %H:%M:%S%n week: %V | day: %u "'

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '\e[3~' delete-char
bindkey '\e[3;5~' kill-word

alias py='python'

vpy()
{
	local venv_name="$1"
	local python_args=("${@:2}")

	if [[ ! -x "$venv_name/bin/python" ]];
	then
		echo "ERROR ==> Python venv not found: '$venv_name/bin/python'" >&2
		return 1
	fi

	"$venv_name/bin/python" "${python_args[@]}"
}

vpip()
{
	local venv_name="$1"
	local pip_args=("${@:2}")
	
	vpy "$venv_name" -m pip "${pip_args[@]}"
}

vx2c()
{
	if (($# != 1));
	then
		echo "ERROR ==> Wrong usage!" >&2
		echo "Parameters: <venv name>"
		return 1
	fi

	local venv_name="$1"

	vpy "$venv_name" -m pyx2cscope
}

alias mnt-crypt='mnt_crypt'
mnt_cyrpt()
{
	if (($# != 3));
	then
		echo "ERROR ==> Wrong usage!" >&2
		echo "Parameters: <device> <mapper name> <mountpoint>"
		return 1
	fi

	local device="$1"
	local mapper_name="$2"
	local mountpoint="$3"
	local mapper="/dev/mapper/$mapper_name"

	if ! sudo cryptsetup open "$device" "$mapper_name";
	then
		echo "ERROR ==> Unable to open '$device'!" >&2
		return 1
	fi

	if ! sudo mount /dev/mapper/"$mapper_name" "$mountpoint";
	then
		echo "ERROR ==> Unable to mount '$mapper'!" >&2
		echo "Undoing cryptsetup for '$mapper' ('$device')..."
		sudo cryptsetup close "$mapper"
		return 1
	fi

	echo "Mounted '$device' ('$mapper') to '$mountpoint'."
}
