# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.shellconf.d/{path,bashrc,bash_prompt,exports,aliases,functions,profile}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;