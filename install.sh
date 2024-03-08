#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob
shopt -s nullglob

# test for a lockfile
echo Starting...

# init a new installation, backing up any current dotfiles
if ! test -f ~/.dotfilelock; then

    echo Backing up dotfiles

    touch ~/.dotfilelock

    find ~/. -maxdepth 3 -type f -name ".*" -print0 | tar -cvf dotfiles.bak.tar --null -T -

fi

myDotfilesFullPath=(~/.config/dotfiles/homedir/.*)
myDotfilesShortPath=( "${myDotfilesFullPath[@]##*/}" )
# for file in "${myDotfilesFullPath[@]}"; do
#     myDotfilesShortPath+=( "${file##*/}" )
#     #echo "$file"
#     echo "${file}"
# done
# unset file
echo "${myDotfilesShortPath[@]}"

if test -f ~/.dotfilelock; then

    # Install/reinstall dotfiles
    for file in "${myDotfilesShortPath[@]}"; do
        if [ -L ~/$file ] ; then
            
            echo removing old symlink for "$file"

            rm ~/$file
        fi

        echo symlinking "$file"
        ln -s ~/.config/dotfiles/homedir/$file ~/$file

    done
    unset file
fi

echo done!
