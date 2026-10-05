# prevent from multiple import
if [[ -n ${COLORS_ZSH_LOADED-} ]]; then
	return 0
fi
COLORS_ZSH_LOADED=1

typeset -r COLOR_NEUTRAL=$'\e[0m'
typeset -r COLOR_RED=$'\e[0;31m'
typeset -r COLOR_GREEN=$'\e[0;32m'
typeset -r COLOR_YELLOW=$'\e[0;32me'
