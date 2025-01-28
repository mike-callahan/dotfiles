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
if [ -f /usr/bin/atuin ] || [ -f "$HOME/.atuin/bin/atuin" ]; then

	if [ -f "$HOME/.atuin/bin/env" ]; then
		. "$HOME/.atuin/bin/env"
	else
		export PATH="$HOME/.atuin/bin:$PATH"
	fi

	[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
	eval "$(atuin init bash --disable-up-arrow)";
else
	echo Atuin might not be installed
fi
