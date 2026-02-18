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

homedir=~/.config/dotfiles/$platform/homedir

if test -f ~/.dotfilelock; then

    # Recursively symlink individual files from homedir
    while IFS= read -r -d '' file; do
        # Get the path relative to homedir (e.g. .fonts/SomeFont.ttf, .local/bin/tjobs)
        relpath="${file#$homedir/}"

        # Create the parent directory in ~ if it doesn't exist
        mkdir -p ~/$(dirname "$relpath")

        # Remove old symlink if present
        if [ -L ~/"$relpath" ]; then
            echo "removing old symlink for $relpath"
            rm ~/"$relpath"
        fi

        echo "symlinking $relpath"
        ln -s "$file" ~/"$relpath"

    done < <(find "$homedir" -type f -print0)

    # Rebuild font cache if .fonts were installed
    if [ -d "$homedir/.fonts" ]; then
        echo "rebuilding font cache"
        fc-cache -fv
    fi

fi

echo done!