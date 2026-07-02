export PATH="/usr/sbin:/sbin:$PATH"

# load git funktions from oh-my-zsh
autoload -Uz vcs_info
precmd() { vcs_info }

# paths & exports
export ZSH="$HOME/.oh-my-zsh"
fpath=(/usr/share/zsh/site-functions $fpath)

# design
ZSH_THEME="simple"

# oh-my-zsh plugins
plugins=(git rust)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# git promt definition
PROMPT='%F{green}%n@%m%f %F{cyan}%~%f%F{yellow}$(git_prompt_info)%f %# '
ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# completion & zstyle
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# oh-my-zsh settings
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

. "$HOME/.cargo/env"
