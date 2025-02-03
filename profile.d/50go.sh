if [ -n "$CC$CXX" ]; then
  go() {
    env -u CC -u CXX go "$@"
  }
fi
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GOMODCACHE="${XDG_CACHE_HOME:-$HOME/.cache}/go/mod"
