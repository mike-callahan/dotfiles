#!/usr/bin/env bash

if test -f ~/.bashrc; then
    mv ~/.bashrc ~/.bashrc.bak
fi

if test -f ~/.profile; then
    mv ~/.profile ~/.profile.bak
fi

if test -f ~/.bash_profile; then
    mv ~/.bash_profile ~/.bash_profile.bak
fi

ln -s ~/.config/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/.config/dotfiles/.bashrc ~/.bashrc