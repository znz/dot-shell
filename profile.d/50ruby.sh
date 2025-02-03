export BUNDLE_USER_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/bundle/config"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME:-$HOME/.local/share}/bundle"

# migration
if [ -f ~/.bundle/config ]; then
    if [ ! -f "$BUNDLE_USER_CONFIG" ]; then
	mkdir -p "$(dirname "$BUNDLE_USER_CONFIG")"
	mv -vi ~/.bundle/config "$BUNDLE_USER_CONFIG"
    fi
fi
