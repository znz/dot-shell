# contrib directory
if [ -d /usr/share/doc/git/contrib ]; then
  # Debian, Ubuntu
  GIT_CONTRIB_DIR=/usr/share/doc/git/contrib
elif [ -d /usr/local/share/git-core/contrib ]; then
  GIT_CONTRIB_DIR=/usr/local/share/git-core/contrib
elif type brew >/dev/null 2>&1; then
  HOMEBREW_PREFIX=$(brew --prefix)
  if [ -d "$HOMEBREW_PREFIX/share/git-core/contrib" ]; then
    GIT_CONTRIB_DIR="$HOMEBREW_PREFIX/share/git-core/contrib"
  fi
  unset HOMEBREW_PREFIX
fi
# diff-highlight
if [ -n "$GIT_CONTRIB_DIR" ]; then
  my_append_path "$GIT_CONTRIB_DIR/diff-highlight"
  unset GIT_CONTRIB_DIR
  export GIT_PAGER='diff-highlight | less'
fi
