alias k=kubectl
alias kpf="kubectl port-forward"

function pods() {
  # Usage
  # pods <namespace>

  if [[ -z "$1" ]]; then
    echo "Usage: pods <namespace>"
    return 1
  fi

  kubectl get pods -n "$1"
}

# Select a pod from a namespace via a fzf dialog
function select-pod() {
  # Usage
  # select-pod <namespace>

  if [[ -z "$1" ]]; then
    echo "Usage: select-pod <namespace>"
    return 1
  fi

  kubectl get pods -n "$1" -oname | fzf --height=5
}

# Select a pod from a namespace via a fzf dialog
function kfbash() {
  # Usage
  # kfbash <namespace> [container]
  
  if [[ -z "$1" ]]; then
    echo "Usage: kfbash <namespace> [container]"
    return 1
  fi

  container="${2:-$1}"
  pod="$(select-pod "$1")"
  kubectl exec -it "$pod" -n "$1" -c "$container" -- bash
}

# Select a pod from a namespace via a fzf dialog and print its logs
function kflog() {
  # Usage
  # kflog <namespace>

  if [[ -z "$1" ]]; then
    echo "Usage: kflog <namespace>"
    return 1
  fi

  namespace="$1"
  shift

  pod="$(select-pod "$namespace")"

  echo "Fetching logs for pod: $pod in namespace: $namespace"

  kubectl logs "$pod" -n "$namespace" $@
}
