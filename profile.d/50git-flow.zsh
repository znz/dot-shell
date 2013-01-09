# see /usr/share/doc/git-flow/README.Debian
if [ -f /usr/share/git-flow/git-flow-completion.zsh ]; then
    source /usr/share/git-flow/git-flow-completion.zsh
fi
# Homebrew
if [ -f /usr/local/share/zsh/functions/git-flow-completion.zsh ]; then
    source /usr/local/share/zsh/functions/git-flow-completion.zsh
elif whence brew >/dev/null; then
   HOMEBREW_PREFIX=$(brew --prefix)
   if [ -f "$HOMEBREW_PREFIX/share/zsh/functions/git-flow-completion.zsh" ]; then
       source "$HOMEBREW_PREFIX/share/zsh/functions/git-flow-completion.zsh"
   fi
   if [ -f "$HOMEBREW_PREFIX/share/zsh/site-functions/git-flow-completion.zsh" ]; then
       source "$HOMEBREW_PREFIX/share/zsh/site-functions/git-flow-completion.zsh"
   fi
   unset HOMEBREW_PREFIX
fi
