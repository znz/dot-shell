if [ -n "$BASH_VERSION" -o -n "$ZSH_VERSION" ]; then
    if type rbenv >/dev/null 2>&1; then
	eval "$(rbenv init -)"
    fi
fi
