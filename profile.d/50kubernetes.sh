export KUBECONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/kube"
export KUBECACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}/kube"

export MINIKUBE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/minikube"

if type kubectl >/dev/null 2>&1; then
  kubectl () {
    unset -f kubectl
    # lazy load
    . <(kubectl completion ${SHELL##*/})
    kubectl "$@"
  }
fi
