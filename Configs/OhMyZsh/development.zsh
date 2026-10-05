source "$ZSH/custom/colors.zsh"

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

alias gum='git_update_main'
function git_update_main
{
	git switch "$(git_main_branch)"

	git merge "$(git_develop_branch)"

	git push

	git switch "$(git_develop_branch)"
}

alias ls-todos='ls_todos'
function ls_todos
{
	if (( $# == 0 )); then
		set -- .
	fi

	for place in "$@"; do
		printf "### '%s' ('%s') ###\n\n" "$place" "$(realpath "$place")"
		rg -ni -- 'todo:' "$place"
	done
}

alias setup-web-project='setup_web_project'
function setup_web_project
{
	if (( $# != 1 )) || [[ -z "$1" ]]; then
		printf "${COLOR_RED}ERROR ==> Project name required!${COLOR_NEUTRAL}\n"
		printf "${COLOR_RED}'$1' is not a valid project name!${COLOR_NEUTRAL}\n"
		exit 1
	fi

	local PROJECT_NAME="$1"

	# create vite project
	npm create vite@latest "$PROJECT_NAME" --yes -- --template react-ts &
	wait $!

	# go into project directory
	if ! cd "$PROJECT_NAME"; then
		printf "${COLOR_RED}ERROR ==> Unable to find project directory '$PROJECT_NAME'${COLOR_NEUTRAL}"
		exit 1
	fi

	# install tailwind with dependencies
	npm install -D tailwindcss @tailwindcss/postcss postcss autoprefixer

	# setup postcss.config.js
	cat << "EOF" > postcss.config.js
	export default {
		plugins: {
			"@tailwindcss/postcss": {},
			autoprefixer: {},
		},
	}
EOF

	# setup src/tailwind.css
	cat << "EOF" > src/tailwind.css
	@import "tailwindcss";
EOF

	# remove src/index.css
	rm src/index.css

	# setup src/main.tsx
	sed -i "/index\.css/d" src/main.tsx
	sed -i "s/'/\"/g" src/main.tsx

	# setup src/App.tsx
	cat << "EOF" > src/App.tsx
	import "./tailwind.css"

	function App() {
		return (
			<div className="h-screen bg-red-500 flex items-center justify-center">
				<h1 className="text-white text-5xl font-black uppercase">
					Hello World!
				</h1>
			</div>
		)
	}

	export default App
EOF

	# remove src/App.css
	rm src/App.css

	# execute
	npm run dev
}
