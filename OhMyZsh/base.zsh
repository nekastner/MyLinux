alias sudo="sudo "

alias src="source $HOME/.zshrc"
alias clr="clear"
alias now="date +\"%Y/%m/%d %H:%M:%S%n week: %V | day: %u \""

alias py="python"

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '\e[3~' delete-char
bindkey '\e[3;5~' kill-word
