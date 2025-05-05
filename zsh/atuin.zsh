# This gets us ^T for searching for a file and alt C for cdd'ing to a directory
source <(fzf --zsh)

# This replaces ^R from above with the atuin UI
echo 'eval "$(atuin init zsh)"' >> ~/.zshrc

