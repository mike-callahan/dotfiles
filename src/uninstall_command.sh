echo "# this file is located in 'src/uninstall_command.sh'"
echo "# code for 'dotfiles uninstall' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

platform=${args[--platform]}

homedir=~/.config/dotfiles/$platform/homedir

if test -f ~/.dotfilelock; then

    # Remove symlinks for all managed files
    while IFS= read -r -d '' file; do
        relpath="${file#$homedir/}"

        # Match the renaming done by install.
        case "$relpath" in
            .bashrc)       relpath=".mikerc" ;;
            .bash_profile) relpath=".mike_profile" ;;
        esac

        # Only remove symlinks that point into this repo's homedir — never
        # delete a symlink the user created themselves.
        if [ -L ~/"$relpath" ]; then
            target=$(readlink ~/"$relpath")
            if [[ "$target" == "$homedir"/* ]]; then
                echo "removing symlink for $relpath"
                rm ~/"$relpath"
            else
                echo "skipping $relpath: symlink not managed by dotfiles (-> $target)"
            fi
        fi

    done < <(find "$homedir" -type f -print0)

else
    echo "Warning! No lockfile was found. Preventing accidental deletion"

fi

echo done!