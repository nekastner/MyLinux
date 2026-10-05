# fix sudo
alias sudo='sudo '

# remove unwanted aliases
unalias mkdir 2> /dev/null
unalias cp 2> /dev/null
unalias mv 2> /dev/null

# utils
alias src="source $HOME/.zshrc"
alias clr='clear'
alias now='date +"%Y.%m.%d %H:%M:%S%n week %V, day %u "'

alias nvim='nvim -p'
alias lsn='ls | sort -n'
alias bata='bat -A'

# key binds
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '\e[3~' delete-char
bindkey '\e[3;5~' kill-word

# mount encrypted devices
alias mount-crypt='mount_crypt'
function mount_crypt
{
	if (($# != 3)); then
		echo "ERROR ==> Wrong usage!"
		echo "Parameters: <device> <mapper name> <mountpoint>"
		return 1
	fi

	local device="$1"
	local mapper_name="$2"
	local mountpoint="$3"
	local mapper="/dev/mapper/$mapper_name"

	if ! sudo cryptsetup open "$device" "$mapper_name"; then
		echo "ERROR ==> Unable to open '$device'!"
		return 1
	fi

	if ! sudo mount /dev/mapper/"$mapper_name" "$mountpoint"; then
		echo "ERROR ==> Unable to mount '$mapper'!"
		echo "Undoing cryptsetup for '$mapper' ('$device')..."
		sudo cryptsetup close "$mapper"
		return 1
	fi

	echo "Mounted '$device' ('$mapper') to '$mountpoint'."
}
