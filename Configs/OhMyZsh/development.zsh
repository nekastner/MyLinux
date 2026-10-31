source "$ZSH/custom/colors.zsh"

alias what-todo-proj='what-todo "$(git rev-parse --show-toplevel)"'
alias what-todo='rg -ni "todo:"'

alias create-c-module='create_c_module'
function create_c_module
{
	for lib_name in "$@"; do
		local h_file_name="${lib_name}.h"
		local c_file_name="${lib_name}.c"
		local macro_name="${lib_name:u}_H"

		printf '#ifndef %s\n#define %s\n\n#endif // %s\n' "$macro_name" "$macro_name" "$macro_name" > "$h_file_name"
		printf '#include "%s"\n' "$h_file_name" > "$c_file_name"
	done
}
