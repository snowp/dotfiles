#!/bin/bash

set -euo pipefail

arch_install() {
  packages=(
    git
    go
    make
    ripgrep
    fzf
    fd
    eza
    zoxide
    yq
    lazygit
    clang
    nodejs-lts-jod
    npm
    ttf-hack-nerd
  )

  # If all the packages are installed then do nothing
  if pacman -Qq "${packages[@]}" &>/dev/null; then
    echo "All packages are already installed."
    return
  fi

  sudo pacman -S "${packages[@]}"
}

macos_install() {
  packages=(
    go
    ripgrep
    fzf
    fd
    eza
    zoxide
    yq
    lazygit
    make
    node
  )

  # If all the packages are installed then do nothing
  if brew list "${packages[@]}" &>/dev/null; then
    echo "All packages are already installed."
    return
  fi

  brew install "${packages[@]}"
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [ -f /etc/arch-release ]; then
    arch_install
  else
    echo "Unsupported Linux distribution. Please install the required packages manually."
    exit 1
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  macos_install
else
  echo "Unsupported OS. Please install the required packages manually."
  exit 1
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "++ Installing TPM (tmux plugin manager). Remember to hit prefix+I to install plugins from tmux."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! which rustup 2>/dev/null 1>/dev/null; then
  echo "++ Installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! which atuin 2>/dev/null 1>/dev/null; then
  echo "++ Installing atuin"
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "++ Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

target="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$target" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

go install github.com/lasorda/protobuf-language-server@latest
