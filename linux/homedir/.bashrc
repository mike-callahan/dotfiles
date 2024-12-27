### Use this dotfile to source other dotfiles or activate shell support for binaries ###

source ~/.config/dotfiles/linux/bashconfig/.aliases
source ~/.config/dotfiles/linux/bashconfig/.exports
source ~/.config/dotfiles/linux/bashconfig/.functions
source ~/.config/dotfiles/linux/bashconfig/.path

# Only source bash_prompt if starship isn't installed
if [ ! -f /usr/bin/starship ]; then
	source ~/.config/dotfiles/linux/bashconfig/.bash_prompt
fi

# Add tab completion for many Bash commands
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi

# Load mise
if [ -f /home/michael/.local/bin/mise ]; then
	eval "$(/home/michael/.local/bin/mise activate bash)";
else
	echo Mise might not be installed
fi

# Load starship
if [ -f /usr/bin/starship ]; then
	eval "$(starship init bash)";
else
	echo Starship might not be installed
fi

# Load atuin
if [ -f /usr/bin/atuin ]; then
	eval "$(atuin init bash --disable-up-arrow)";
else
	echo Atuin might not be installed
fi