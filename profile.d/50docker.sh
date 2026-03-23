export DOCKER_BUILDKIT=1
if [ ! -d ~/.docker ]; then
    export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
fi

if ! grep -q /opt/homebrew/lib/docker/cli-plugins "$DOCKER_CONFIG/config.json"; then
    jq '.["cliPluginsExtraDirs"] |= (.+["/opt/homebrew/lib/docker/cli-plugins"] | unique)' "$DOCKER_CONFIG/config.json" > "$DOCKER_CONFIG/config.json.$$"
    mv "$DOCKER_CONFIG/config.json.$$" "$DOCKER_CONFIG/config.json"
fi
