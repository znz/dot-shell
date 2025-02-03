if [ ! -d ~/.npm ]; then
    export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
    [ -f "$NPM_CONFIG_USERCONFIG" ] || {
	mkdir -p "$(dirname "$NPM_CONFIG_USERCONFIG")"
	cat >"$NPM_CONFIG_USERCONFIG" <<'EOF'
prefix=${XDG_DATA_HOME}/npm
cache=${XDG_CACHE_HOME}/npm
init-module=${XDG_CONFIG_HOME}/npm/config/npm-init.js
logs-dir=${XDG_STATE_HOME}/npm/logs
EOF
    }
fi
