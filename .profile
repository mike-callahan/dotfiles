### setup bash ###

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{path,bashrc,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

### override bash defaults ###
shopt -s cdspell;

#### bash history fix ###
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
HISTSIZE=9000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

_bash_history_sync() {
    builtin history -a         #1
    HISTFILESIZE=$HISTSIZE     #2
    builtin history -c         #3
    builtin history -r         #4
}

history() {                  #5
    _bash_history_sync
    builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync