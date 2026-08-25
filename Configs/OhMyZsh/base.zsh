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

vpy() {

  local venv_dir="$1"
  local python_args=("${@:2}")

  [[ -x "$venv_dir/bin/python" ]] || {
    echo "Python venv not found: $venv_dir/bin/python" >&2
    return 1
  }

  "$venv_dir/bin/python" "${python_args[@]}"
}

vpip() {

  local venv_dir="$1"
  local python_args=("${@:2}")

  [[ -x "$venv_dir/bin/python" ]] || {
    echo "Python venv not found: $venv_dir/bin/python" >&2
    return 1
  }

  "$venv_dir/bin/python" -m pip "${python_args[@]}"
}

mnt-crpt() {

  local device=$1
  local mapper=$2
  local mountpoint=$3

  (( $# == 3 )) || {
    print "Usage: mnt-crpt <device> <mapper-name> <mountpoint>"
    return 1
  }

  sudo cryptsetup open "$device" "$mapper" || return

  sudo mount "/dev/mapper/$mapper" "$mountpoint" || {
    sudo cryptsetup close "$mapper"
    return 1
  }

  print "Mounted $device -> $mountpoint"
}



