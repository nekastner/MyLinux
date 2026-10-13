source "$ZSH/custom/colors.zsh"

alias py='python'



function vpa
{
	local venv_name="$1"

	if (( $# != 1 )); then
		printf "${COLOR_RED}ERROR ==> Wrong usage!{COLOR_NEUTRAL}\n"
		printf "Parameters: <venv name>"
		return 1
	fi

	if [[ ! -x "$venv_name/bin/python" ]]; then
		printf "${COLOR_RED}ERROR ==> Python venv not found: '$venv_name/bin/python'${COLOR_NEUTRAL}\n"
		return 1
	fi

	source "$venv_name/bin/activate"
}

function vpd
{
	if (( $# != 0 )); then
		printf "${COLOR_RED}ERROR ==> Wrong usage!{COLOR_NEUTRAL}\n"
		printf "Parameters: none"
		return 1
	fi

	if [[ -z "$VIRTUAL_ENV" ]]; then
		printf "${COLOR_RED}ERROR ==> No venv active!${COLOR_NEUTRAL}\n"
		exit 1
	fi

	deactivate
}

function vpy
{
	local venv_name="$1"
	local python_args=("${@:2}")

	if [[ ! -x "$venv_name/bin/python" ]]; then
		printf "${COLOR_RED}ERROR ==> Python venv not found: '$venv_name/bin/python'${COLOR_NEUTRAL}\n"
		return 1
	fi

	"$venv_name/bin/python" "${python_args[@]}"
}

function vpip
{
	local venv_name="$1"
	local pip_args=("${@:2}")

	vpy "$venv_name" -m pip "${pip_args[@]}"
}
