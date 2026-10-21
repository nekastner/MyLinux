### PULL ###

alias gld='git-pull-develop'
alias git-pull-develop='git_pull_branch $(git_develop_branch)'

alias glm='git-pull-main'
alias git-pull-main='git_pull_branch $(git_main_branch)'

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

### UPDATE (MERGE + PUSH) ###

alias gud='git-update-develop'
alias git-update-develop='git_update_branch $(git_develop_branch) $(git rev-parse --abbrev-ref HEAD)'

alias gum='git-update-main'
alias git-update-main='git_update_branch $(git_main_branch) $(git_develop_branch)'

alias gub='git-update-branch'
alias git-update-branch='git_update_branch'
function git_update_branch
{

	local target_git_branch="$1"
	local source_git_branch="$2"

	local current_git_branch="$(git rev-parse --abbrev-ref HEAD)"

	git switch "$target_git_branch"

	printf '\n'

	git merge "$source_git_branch"

	printf '\n'

	git push

	printf '\n'

	git switch "$current_git_branch"
}

### CONFIG/MODULES INFORMATION ###

alias gsc='git-show-config'
alias git-show-config='cat "$(git rev-parse --show-toplevel)/.git/config"'

alias gls='git-list-submodules'
alias git-list-submodules='ls -1 "$(git rev-parse --show-toplevel)/.git/modules"'

### INFORMATION IN GENERAL ###

alias gccs='git-count-commits'
alias git-count-commits='git rev-list --count HEAD'

### COMPARISON ###

alias pgd='print-git-diff'
alias print-git-diff='print_git_diff'
function print_git_diff
{
	git diff "$@" | bat
}

alias gdh='git-diff-head'
alias git-diff-head='git diff HEAD'

alias pgdh='print-git-diff-head'
alias print-git-diff-head='git-diff-head | bat'

alias gcd='git-compare-develop'
alias git-compare-develop='git_compare_branches $(git_develop_branch) %(git rev-parse --abbrev-ref HEAD)'

alias gcm='git-compare-main'
alias git-compare-main='git_compare_branches $(git_main_branch) $(git_develop_branch)'

alias gcb='git-compare-branches'
alias git-compare-branches='git_compare_branches'
function git_compare_branches
{
	local branch1_name="$1"
	local branch2_name="$2"

	read -r branch1_ahead_by branch2_ahead_by < <(
		git rev-list --left-right --count "$branch1_name...$branch2_name"
	)

	local branch1_name_length=${#branch1_name}
	local branch2_name_length=${#branch2_name}
	local branch_name_longest=0
	if (( branch1_name_length > branch2_name_length )); then
		branch_name_longest=$branch1_name_length
	else
		branch_name_longest=$branch2_name_length
	fi

	printf "%-*s %s\n" "$branch_name_longest" "$branch1_name" "$branch2_name"
	printf "%-*s %s\n" "$branch_name_longest" "$branch1_ahead_by" "$branch2_ahead_by"
}
