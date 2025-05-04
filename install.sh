#!/bin/bash

set -euo pipefail


arch_install() {
	sudo pacman -S ripgrep yq lazygit clang  nodejs-lts-jod
}

arch_install

if [[ -z ~/.tmux/plugins/tpm ]]; then
	echo "++ Installing TPM (tmux pluing manager. Remember to hit prefix+I to install plugins from tmux."
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! which rustup; then
echo "++ Installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
