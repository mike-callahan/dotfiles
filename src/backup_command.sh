echo "# this file is located in 'src/backup_command.sh'"
echo "# code for 'dotfiles backup' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

platform=${args[--platform]}

# Backup dotfiles

echo Backing up dotfiles
printf -v date '%(%Y-%m-%d_%H%M%S)T' -1
find ~/. -maxdepth 3 -type f -name ".*" -print0 | tar -cvf "dotfiles.tar-$date" --null -T -