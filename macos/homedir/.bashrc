### Use this dotfile to source other dotfiles or activate shell support for binaries ###

# for non-interactive sessions stop execution here -- https://serverfault.com/a/805532/67528
[[ $- != *i* ]] && return

# Source secrets (gitignored) before other configs that may reference them
if [ -f ~/.config/dotfiles/macos/bashconfig/.secrets ]; then
	source ~/.config/dotfiles/macos/bashconfig/.secrets
fi

source ~/.config/dotfiles/macos/bashconfig/.aliases
source ~/.config/dotfiles/macos/bashconfig/.exports
source ~/.config/dotfiles/macos/bashconfig/.functions
source ~/.config/dotfiles/macos/bashconfig/git.functions
source ~/.config/dotfiles/macos/bashconfig/.path

if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add tab completion for many Bash commands
if [ -f /opt/homebrew/etc/bash_completion ]; then
	source /opt/homebrew/etc/bash_completion;
fi

# Only source bash_prompt if starship isn't installed
if [ ! -f /opt/homebrew/bin/starship ]; then
	source ~/.config/dotfiles/macos/bashconfig/.bash_prompt
fi

# Load mise
if [ -f /opt/homebrew/bin/mise ]; then
    eval "$(/opt/homebrew/bin/mise activate bash)";
else
    echo Mise might not be installed
fi

# Load starship
if [ -f /opt/homebrew/bin/starship ]; then
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

export PATH="$PATH:$HOME/.local/bin"
