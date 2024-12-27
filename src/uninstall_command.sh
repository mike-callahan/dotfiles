echo "# this file is located in 'src/uninstall_command.sh'"
echo "# code for 'dotfiles uninstall' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

platform=${args[--platform]}

myDotfilesFullPath=(~/.config/dotfiles/$platform/homedir/.*)
myDotfilesShortPath=( "${myDotfilesFullPath[@]##*/}" )

echo "${myDotfilesShortPath[@]}"

if test -f ~/.dotfilelock; then

    # Install/reinstall dotfiles
    for file in "${myDotfilesShortPath[@]}"; do
        if [ -L ~/$file ] ; then
            
            echo removing old symlink for "$file"
            rm ~/$file

        fi
    done

    unset file

else
    echo "Warning! No lockfile was found. Preventing accidental deletion"

fi

echo done!