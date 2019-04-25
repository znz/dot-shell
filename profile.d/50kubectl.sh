if type kubectl >/dev/null 2>&1; then
  kubectl () {
    unset -f kubectl
    # lazy load
    source <(kubectl completion ${SHELL##*/})
    kubectl "$@"
  }
fi
