# lazy loading
rbenv () {
    if [ -n "$rvm_path" ]; then
	echo "rvm is enabled."
	return 1
    fi
    if [ -n "$BASH_VERSION" -o -n "$ZSH_VERSION" ]; then
	if [ -d "$HOME/.rbenv/bin" ]; then
	    PATH="$HOME/.rbenv/bin:$PATH"
	fi
	unset -f rbenv
	if type rbenv >/dev/null 2>&1; then
	    eval "$(rbenv init -)"
	fi
	rbenv "$@"
    else
	echo "$SHELL is not supported."
	return 1
    fi
}

# rvm is not installed.
if [[ ! -s "$HOME/.rvm/scripts/rvm" ]]  ; then
    if [ -d "$HOME/.rbenv/bin" ]; then
	PATH="$HOME/.rbenv/bin:$PATH"
    fi
    unset -f rbenv
    if type rbenv >/dev/null 2>&1; then
	eval "$(rbenv init -)"
    fi
fi
