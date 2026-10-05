source "$ZSH/custom/colors.zsh"

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
