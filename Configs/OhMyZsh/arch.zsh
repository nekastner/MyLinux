alias fix-pgp-key='gpg --keyserver hkps://keys.openpgp.org --recv-keys'

alias show-install-history='expac --timefmt="%Y.%m.%d %T" "%l\t%n -> Required by: %N" | sort -n'
alias show-orphaned-packages='pacman -Qdt'
