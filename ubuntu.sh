#!/bin/bash

REPOS_DIR=$HOME/Development
DOTFILES_DIR=$(pwd)

if [ "$(dirname "$(realpath "$0")")" != "$DOTFILES_DIR" ]; then
  echo 'run this script from the dotfiles repo!'
  exit 1
fi

mkdir -p "$REPOS_DIR"

sudo apt-get -y install curl

# Install rustup, needed for alacritty
which rustup
if [ $? -eq 1 ]; then
  curl https://sh.rustup.rs -sSf | sh
  rustup update
fi

apt-cache policy alacritty|grep Installed >/dev/null
if [ $? -eq 1 ]; then
  # Install alacritty
  pushd "$REPOS_DIR"
    git clone https://github.com/jwilm/alacritty.git
    cargo install cargo-deb
    # install dependencies
    sudo apt-get install xclip
    cargo deb --install
  popd
fi

# Install tmux + tmux config
sudo apt-get -y install tmux

# If tmux.conf isn't a symlink, set up tmux config
test -L "$HOME/.tmux.conf"
if [ $? -eq 1 ]; then
  pushd "$REPOS_DIR"
    git clone https://github.com/gpakosz/.tmux.git
  popd

  pushd "$HOME"
    ln -sf "$REPOS_DIR/.tmux/.tmux.conf"
    # link in the .tmux.conf.local from the dotfiles repo
    # so we can override config
    ln -sf "$DOTFILES_DIR/.tmux.conf.local" .
  popd
fi

# Install wd
which wd
if [ $? -eq 1 ]; then
  curl -L https://github.com/mfaerevaag/wd/raw/master/install.sh | sh
fi

