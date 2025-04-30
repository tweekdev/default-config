#!/bin/bash

# create symlinks
cd ~/ ; ln -s ~/.config/dotfiles/.zshrc
cd ~/ ; ln -s ~/.config/dotfiles/tmux/.tmux.conf
cd ~/ ; ln -s ~/.config/dotfiles/.gitconfig
cd ~/ ; ln -s ~/.config/dotfiles/.gitignore_global
cd ~/ ; ln -s ~/.config/dotfiles/.z

cd ~/.config/ ; ln -s ~/.config/dotfiles/kitty

cd ~/.config/ ; ln -s ~/.config/dotfiles/nvim

cd ~/.config/ ; ln -s ~/.config/dotfiles/sesh

cd ~/.config/ ; ln -s ~/.config/dotfiles/starship.toml

