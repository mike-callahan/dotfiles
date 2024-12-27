#echo "# this file is located in 'src/install_command.sh'"
#echo "# code for 'dotfiles install' goes here"
#echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

platform=${args[--platform]}
# init a new installation, backing up any current dotfiles
if ! test -f ~/.dotfilelock; then

    echo Backing up existing dotfiles
    touch ~/.dotfilelock
    printf -v date '%(%Y-%m-%d_%H%M%S)T' -1
    find ~/. -maxdepth 3 -type f -name ".*" -print0 | tar -cvf "dotfiles.tar-$date" --null -T -

fi

# reload fonts
# fc-cache -fv
# starship preset nerd-font-symbols -o ~/.config/starship.toml
GLOBIGNORE=.:..; 
myDotfilesFullPath=(~/.config/dotfiles/$platform/homedir/.*)
myDotfilesShortPath=( "${myDotfilesFullPath[@]##*/}" )
unset GLOBIGNORE
echo "${myDotfilesShortPath[@]}"

if test -f ~/.dotfilelock; then

    # Install/reinstall dotfiles
    for file in "${myDotfilesShortPath[@]}"; do
        if [ -L ~/$file ] ; then
            
            echo removing old symlink for "$file"
            rm ~/$file
        fi

        echo symlinking "$file"
        ln -s ~/.config/dotfiles/$platform/homedir/$file ~/$file

    done
    unset file
fi

echo done!