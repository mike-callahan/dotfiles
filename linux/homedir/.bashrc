shopt -s checkwinsize
shopt -s globstar

source ~/.config/dotfiles/bashconfig/.aliases
source ~/.config/dotfiles/bashconfig/.bash_prompt
source ~/.config/dotfiles/bashconfig/.exports
source ~/.config/dotfiles/bashconfig/.functions
eval "$(/home/michael/.local/bin/mise activate bash)"
eval "$(starship init bash)"
eval "$(atuin init bash --disable-up-arrow)"
