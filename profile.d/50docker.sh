export DOCKER_BUILDKIT=1
if [ ! -d ~/.docker ]; then
    export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
fi
