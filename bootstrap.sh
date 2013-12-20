#!/usr/bin/env bash
OPTIND=1

cd "$(dirname "${BASH_SOURCE}")"

function linkIt() {
	FILES=$(find . -type f -maxdepth 1 -name ".*" -not -name .DS_Store -not -name .git -not -name .osx | sed -e 's|//|/|' | sed -e 's|./.|.|')
  	for file in $FILES; do 
		ln -sf $(dirname "${BASH_SOURCE}")/${file} ~/${file}
	done	
}

while getopts "f" opt; do
	case "$opt" in
		f)
			FORCE=1
			;;
	esac
done

if [ "$FORCE" == "1" ]; then
	linkIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		linkIt
	fi
fi
source ~/.zshrc
unset linkIt
