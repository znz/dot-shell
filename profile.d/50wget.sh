export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wgetrc"
if ! grep -q hsts-file "$WGETRC" >/dev/null 2>&1; then
    echo hsts-file \= "${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts" >> "$WGETRC"
fi

# migration
if [ -f "$HOME/.wget-hsts" ]; then
    mv -vi "$HOME/.wget-hsts" "${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"
fi
