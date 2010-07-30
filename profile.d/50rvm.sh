if [ -n "$BASH_VERSION" -o -n "$ZSH_VERSION" ]; then
    if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then
	. "$HOME/.rvm/scripts/rvm"
    fi
fi
