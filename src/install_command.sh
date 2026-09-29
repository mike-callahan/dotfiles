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

        # Bash startup files are installed under alternate names so an existing
        # .bashrc / .bash_profile is left untouched and can source these.
        case "$relpath" in
            .bashrc)       relpath=".mikerc" ;;
            .bash_profile) relpath=".mike_profile" ;;
        esac

        # Create the parent directory in ~ if it doesn't exist
        mkdir -p ~/$(dirname "$relpath")

        # Remove old symlink if present, but only if it points into this repo's
        # homedir — never delete a symlink the user created themselves.
        if [ -L ~/"$relpath" ]; then
            target=$(readlink ~/"$relpath")
            if [[ "$target" == "$homedir"/* ]]; then
                echo "removing old symlink for $relpath"
                rm ~/"$relpath"
            elif [[ ${args[--skip-existing]} ]]; then
                echo "skipping existing symlink (not managed by dotfiles): $relpath -> $target"
                continue
            else
                echo "error: symlink already exists and is not managed by dotfiles: ~/$relpath -> $target (use --skip-existing to skip)"
                exit 1
            fi
        elif [ -e ~/"$relpath" ]; then
            if [[ ${args[--skip-existing]} ]]; then
                echo "skipping existing file: $relpath"
                continue
            else
                echo "error: file already exists: ~/$relpath (use --skip-existing to skip)"
                exit 1
            fi
        fi

        echo "symlinking $relpath"
        ln -s "$file" ~/"$relpath"

    done < <(find "$homedir" -type f -print0)

    # Rebuild font cache if .fonts were installed
    if [ -d "$homedir/.fonts" ]; then
        echo "rebuilding font cache"
        fc-cache -fv
    fi

    # Offer to wire the installed files into the real bash startup files.
    # Never append through a symlink — that would write into whatever it points
    # at (e.g. a repo file or .mikerc itself, which would then source itself).
    read -r -p "Source .mikerc/.mike_profile from your ~/.bashrc and ~/.bash_profile? [y/N] " reply
    if [[ $reply == [yY]* ]]; then
        if [ -L ~/.bashrc ]; then
            echo "warning: ~/.bashrc is a symlink (-> $(readlink ~/.bashrc)); not touching it. Remove it and re-run install to create a real file."
        elif grep -qsF 'source ~/.mikerc' ~/.bashrc; then
            echo "~/.bashrc already sources .mikerc"
        else
            printf '\n[ -f ~/.mikerc ] && source ~/.mikerc\n' >> ~/.bashrc
            echo "added source line to ~/.bashrc"
        fi
        if [ -L ~/.bash_profile ]; then
            echo "warning: ~/.bash_profile is a symlink (-> $(readlink ~/.bash_profile)); not touching it. Remove it and re-run install to create a real file."
        elif grep -qsF 'source ~/.mike_profile' ~/.bash_profile; then
            echo "~/.bash_profile already sources .mike_profile"
        else
            printf '\n[ -f ~/.mike_profile ] && source ~/.mike_profile\n' >> ~/.bash_profile
            echo "added source line to ~/.bash_profile"
        fi
    fi

fi

echo done!