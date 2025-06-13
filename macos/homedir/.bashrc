### Use this dotfile to source other dotfiles or activate shell support for binaries ###

source ~/.config/dotfiles/linux/bashconfig/.aliases
source ~/.config/dotfiles/linux/bashconfig/.exports
source ~/.config/dotfiles/linux/bashconfig/.functions
source ~/.config/dotfiles/linux/bashconfig/.path

if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add tab completion for many Bash commands
if [ -f /opt/homebrew/etc/bash_completion ]; then
	source /opt/homebrew/etc/bash_completion;
fi

# Only source bash_prompt if starship isn't installed
if [ ! -f /usr/bin/starship ]; then
	source ~/.config/dotfiles/linux/bashconfig/.bash_prompt
fi

# Load starship
if [ -f /usr/bin/starship ]; then
	eval "$(starship init bash)";
else
	echo Starship might not be installed
fi

# Load atuin
if [ -f /opt/homebrew/bin/atuin ]; then

	[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
	eval "$(atuin init bash --disable-up-arrow)";
else
	echo Atuin might not be installed
fi
