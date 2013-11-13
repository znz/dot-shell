if [ -d "$HOME/.anyenv/bin" ]; then
  PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi
