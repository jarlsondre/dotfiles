#!/bin/sh
# ln -s <path to the file/folder to be linked> <the path of the link to be created>
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/nvim ~/.config/nvim

# To install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
~/.tmux/plugins/tpm/bin/install_plugins
