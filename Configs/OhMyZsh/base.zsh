source "$ZSH/custom/colors.zsh"

# utils
alias src="source $HOME/.zshrc"
alias clr='clear'
alias now='date +"%Y.%m.%d %H:%M:%S%n week %V, day %u "'

# default flags
alias nvim='nvim -p'
alias eza='eza -a'

# quick flags
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
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" 'ERROR ==> Wrong usage!'
		printf 'Parameters: <device> <mapper name> <mountpoint>\n'
		return 1
	fi

	local device="$1"
	local mapper_name="$2"
	local mountpoint="$3"
	local mapper="/dev/mapper/$mapper_name"

	if ! sudo cryptsetup open "$device" "$mapper_name"; then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" "ERROR ==> Unable to open '$device'!"
		return 1
	fi

	if ! sudo mount /dev/mapper/"$mapper_name" "$mountpoint"; then
		printf "${COLOR_RED}%s${COLOR_NEUTRAL}\n" "ERROR ==> Unable to mount '$mapper'!"
		printf "Undoing cryptsetup for '$mapper' ('$device')...\n"
		sudo cryptsetup close "$mapper"
		return 1
	fi

	printf "${COLOR_GREEN}%s${COLOR_NEUTRAL}\n" "Mounted '$device' ('$mapper') to '$mountpoint'."
}
