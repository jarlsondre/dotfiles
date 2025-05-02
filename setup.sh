#!/bin/sh

# Setting up symbolic links
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/aliases.sh ~/.aliases

mkdir ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim

# Setting up plugins for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
~/.tmux/plugins/tpm/bin/install_plugins
