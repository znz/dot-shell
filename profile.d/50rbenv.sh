if [ -n "$BASH_VERSION" -o -n "$ZSH_VERSION" ]; then
    if [ -d "$HOME/.rbenv/bin" ]; then
        PATH="$HOME/.rbenv/bin:$PATH"
    fi
    if type rbenv >/dev/null 2>&1; then
	eval "$(rbenv init -)"
    fi
fi
