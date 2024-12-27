### Use this dotfile for configuring login shell options ###

# Create default CRD desktop sizes
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768,1600x1200,1728x1080,3456x2160,3840x2160

# Use ubuntu-desktop in CRD sessions when on ubuntu
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == :"Ubuntu" ]; then
    export GNOME_SHELL_SESSION_MODE=ubuntu
    export XDG_CURRENT_DESKTOP=ubuntu:GNOME
    export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
fi

# Load any bashrc values if using an interactive shell
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi