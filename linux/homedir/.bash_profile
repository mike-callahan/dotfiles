### Use this dotfile for configuring login shell options ###

# Create default CRD desktop sizes
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768,1600x1200,1728x1080,3456x2160,3840x2160

OS_RELEASE="$(awk -F= '/^NAME/{print $2}' /etc/os-release)"
OS_RELEASE="${OS_RELEASE%\"}" # remove trailing and leading quotes
OS_RELEASE="${OS_RELEASE#\"}"

# Use ubuntu-desktop in CRD sessions when on ubuntu
if [ "$OS_RELEASE" == "Ubuntu" ]; then
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
