source "$ZSH/custom/colors.zsh"

alias py='python'

alias vpy='uv run python'

function vpa
{
	local venv_path="$1"
	if [[ -z "$venv_path" ]]; then
		venv_path="$(uv run --no-sync python -c 'import sys; print(sys.prefix)')"
	fi

	source "$venv_path/bin/activate"
}

function vps
{
	printf 'Currently active python venv: %s' "$(python -c 'import sys; print(sys.prefix)')"
}

function vpd
{
	if [[ -z "$VIRTUAL_ENV" ]]; then
		printf "${COLOR_YELLOW}There seems to be no currently active python venv!${COLOR_NEUTRAL}\n"
		return 0
	fi

	deactivate
}
