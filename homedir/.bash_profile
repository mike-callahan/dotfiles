### override bash defaults ###
shopt -s cdspell;

export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768,1600x1200,1728x1080,3456x2160,3840x2160
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg

if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

