# when homebrew installed to $HOME/homebrew
#fpath=($fpath $HOME/homebrew/share/zsh/site-functions(N))
fpath=($fpath ${commands[brew]:h:h}/share/zsh/site-functions(N))
# brew install zsh-completions
fpath=(${commands[brew]:h:h}/share/zsh-completions(N) $fpath)
