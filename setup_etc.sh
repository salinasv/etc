#!/usr/bin/env bash

# TODO: Set a better regex
XDG_STRING="lua"

# Check if the file exist to back it up.
# Then create a symlink in the $HOME to this file.
function link_file {
	XDG=`grep ${XDG_STRING} ${FILE}`
	# TODO: Move this files to .${XDG_*}
	# Skip XDG files for now.
	if [[ -n ${XDG} ]]
	then
		echo "XDG FILE related file: ${FILE}"
		continue
	fi

	## Move to home
	# Backup files if they exists
	if [ -e "${HOME}/.${1}" ]; then
		mv ${HOME}/.${1}{,_bkp}
	fi
	ln -s `pwd`/${1} ../.${1}

}

# Move standard RC files.
for FILE in `ls *rc*`
do
	link_file ${FILE}
done

# Special files/dirs
## Vim
link_file vim
## X11
link_file Xdefaults
## Awesome
## TODO:rc.lua revelation.lua
#link_file revelation
