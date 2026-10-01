# ADD PATHS TO $PATH

PATHS_TO_ADD_TO_PATH=(
	"$HOME/MyLinux/Scripts/Arch"
	"$HOME/MyLinux/Scripts/General"
)

for path_to_add_to_path in "${PATHS_TO_ADD_TO_PATH[@]}";
do
	export PATH="$PATH:$path_to_add_to_path"
done

# RUN SCRIPTS
#"$HOME/MyLinux/Configs/UPDATE.sh"
