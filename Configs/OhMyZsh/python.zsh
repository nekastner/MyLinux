alias py='python'

function vpy
{
	local venv_name="$1"
	local python_args=("${@:2}")

	if [[ ! -x "$venv_name/bin/python" ]]; then
		echo "ERROR ==> Python venv not found: '$venv_name/bin/python'"
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
