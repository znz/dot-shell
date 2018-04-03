if type npm >/dev/null 2>&1; then
  # overwrite after compinit
  _npm () {
    unfunction _npm
    eval "$(npm completion)"
  }
fi
