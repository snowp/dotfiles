source "$HOME/.cargo/env"

function rtest() {
  cargo nextest run $@
}

function rt() {
  cargo nextest run $@
}
