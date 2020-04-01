if [ -n "$CC$CXX" ]; then
  go() {
    env -u CC -u CXX go "$@"
  }
fi
