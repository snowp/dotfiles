function n() {
  nvim "$@"
}

export EDITOR=nvim

function clear-nvim-swap-files() {
  # Find and delete all swap files created by nvim
  find ~/.local/state/nvim/swap -type f -name '.*.sw[po]' -exec rm -f {} +
  echo "All nvim swap files have been deleted."
}
