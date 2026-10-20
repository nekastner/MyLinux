SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/colors.sh"

function git_main_branch
{
	printf 'main'
}
function git_develop_branch
{
	printf 'develop'
}

alias gld='git-pull-develop'
alias git-pull-develop="git_pull_branch $(git_develop_branch)"

alias glm='git-pull-main'
alias git-pull-main="git_pull_branch $(git_main_branch)"

alias glb='git-pull-branch'
alias git-pull-branch='git_pull_branch'
function git_pull_branch
{
	local target_git_branch="$1"
	local current_git_branch="$(git rev-parse --abbrev-ref HEAD)"

	git switch "$target_git_branch"

	printf '\n'

	git pull

	printf '\n'

	git switch "$current_git_branch"
}

alias gud='git-update-develop'
alias git-update-develop="git_update_branch $(git_develop_branch)"

alias gum='git-update-main'
alias git-update-main="git_update_branch $(git_main_branch)"

alias gub='git-update-branch'
alias git-update-branch='git_update_branch'
function git_update_branch
{
	local target_git_branch="$1"
	local current_git_branch="$(git rev-parse --abbrev-ref HEAD)"

	git switch "$target_git_branch"

	printf '\n'

	git merge "$current_git_branch"

	printf '\n'

	git push

	printf '\n'

	git switch "$current_git_branch"
}

alias gsc='git-show-config'
alias git-show-config='cat "$(git rev-parse --show-toplevel)/.git/config"'

alias gls='git-list-submodules'
alias git-list-submodules='ls -1 "$(git rev-parse --show-toplevel)/.git/modules"'

# git branch compare (how much ahead of each other)
alias gbc='git-branch-compare'
alias git-branch-compare='git_branch_compare'
function git_branch_compare
{
	# determine names of branches
	local branch1_name branch2_name
	if (( $# == 2 )); then
		branch1_name="$1"
		branch2_name="$2"
	else
		branch1_name="$(git_main_branch)"
		branch2_name="$(git_develop_branch)"
	fi

	# check how far ahead the branches are of each other
	read -r branch1_ahead_by branch2_ahead_by < <(
		git rev-list --left-right --count "$branch1_name...$branch2_name"
	)

	# calculate column width for output
	local branch1_name_length=${#branch1_name}
	local branch2_name_length=${#branch2_name}
	local branch_name_longest=0
	if (( branch1_name_length > branch2_name_length )); then
		branch_name_longest=$branch1_name_length
	else
		branch_name_longest=$branch2_name_length
	fi

	# output
	printf "%-*s %s\n" "$branch_name_longest" "$branch1_name" "$branch2_name"
	printf "%-*s %s\n" "$branch_name_longest" "$branch1_ahead_by" "$branch2_ahead_by"
}

# general
alias g='git'
alias gst='git status'
alias gsh='git show'

# diff
alias gd='git diff'
alias gdh='git diff HEAD'

# clone
alias gcl='git clone --recurse-submodules'
function gccd { git clone --recurse-submodules "$@" && cd "$(basename $_ .git)"; }

# remote
alias gr='git remote'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'
alias grv='git remote -v'

# log
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glo='git log --oneline --decorate'

# add
alias ga='git add'
alias gaa='git add --all'

# commit
alias gcam='git commit --all --message'
alias gcmsg='git commit --message'
alias gc!='git commit --amend'

# restore
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'

# reset
alias grh='git reset'
alias gru='git reset --'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'

# push
alias gp='git push'
alias gpd='git push --dry-run'
alias gpv='git push --verbose'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpu='git push upstream'

# fetch
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune'
alias gfo='git fetch origin'

# pull
alias gl='git pull'

# merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms='git merge --squash'
alias gmff='git merge --ff-only'

# rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'

# switch
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm="git switch $(git_main_branch)"
alias gswd="git switch $(git_develop_branch)"

# branch
alias gb='git branch'
alias gbr='git branch --remote'

# checkout
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcB='git checkout -B'