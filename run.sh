#!/bin/bash

MODE=$1


if [[ -z $MODE ]]; then
  echo "Usage: $0 {all|links|install}"
  exit 1
fi

if [[ $MODE == "install" || $MODE == "all" ]]; then
  # install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  softwareupdate --install-rosetta

  cd ~/Downloads
  curl -L -o Docker.dmg "https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64"
 
 #install nvm and node
  brew install nvm

  export NVM_DIR="$HOME/.nvm"
  source "$(brew --prefix nvm)/nvm.sh"

  nvm install --lts
  nvm use --lts
  
  # install npm and yarn
  npm install -g yarn

  npm install typescript --save-dev

  # install neovim, tmux and fzf and bat
  brew install neovim tmux fzf bat git zsh eza zoxide gh lazygit coursier/formulas/coursier starship ripgrep git-flow-avh gnu-tar postgresql pigz
  brew install --cask google-cloud-sdk raycast
  

  cd ~
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions



  # install kitty
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

  # install tmux plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi



if [[ $MODE == "links" || $MODE == "all" ]]; then
  if [ -f "$HOME/.zshrc" ]; then
    rm -f $HOME/.zshrc
  fi


  if [ -f "$HOME/.tmux.conf" ]; then
    rm -f $HOME/.tmux.conf
  fi


  if [ -f "$HOME/.gitconfig" ]; then
    rm -f $HOME/.gitconfig
  fi


  if [ -f "$HOME/.gitignore_global" ]; then
    rm -f $HOME/.gitignore_global
  fi


  if [ -f "$HOME/.z" ]; then
    rm -f $HOME/.z
  fi


  if [ -d "$HOME/.config/nvim" ]; then
    rm -rf $HOME/.config/nvim
  fi


  if [ -d "$HOME/.config/kitty" ]; then
    rm -rf $HOME/.config/kitty
  fi


  if [ -d "$HOME/.config/sesh" ]; then
    rm -rf $HOME/.config/sesh
  fi


  if [ -f "$HOME/.config/starship.toml" ]; then
    rm -rf $HOME/.config/starship.toml
  fi


  mkdir -p ~/.config
  
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
fi


