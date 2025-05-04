#!/bin/bash

set -euo pipefail

arch_install() {
  sudo pacman -S which tmux nvim zsh
}

arch_install
