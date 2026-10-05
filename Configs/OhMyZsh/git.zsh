alias gdh='git diff HEAD'

alias gum='git_update_main'
function git_update_main
{
	git switch "$(git_main_branch)"

	git merge "$(git_develop_branch)"

	git push

	git switch "$(git_develop_branch)"
}

# git branch compare (how much ahead of each other)
alias gbc='git-branch-compare'
function git_branch_compare
{
	# determine names of branches
	local branch1_name branch2_name
	if (( $# == 2 )); then
		branch1_name="$1"
		branch2_name="$2"

	elif [[ -f "$ZSH/plugins/git/git.plugin.zsh" ]]; then
		branch1_name="$(git_main_branch)"
		branch2_name="$(git_develop_branch)"

	else
		printf "${COLOR_RED}ERROR ==> Wrong usage!${COLOR_NEUTRAL}}\n"
		printf "Parameters: <branch 1> <branch 2>\n"
		printf "Hint: Alternatively install the git plugin and create a main and a develop branch."
		return 1
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
