while IFS=';' read -r source target;
do
	target="${target//\$HOME/$HOME}"
	echo "$source -> $target"
done < source_target.relations
