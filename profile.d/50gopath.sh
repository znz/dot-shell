if [ -z "${GOPATH:-}" ]; then
    export GOPATH=$HOME/g
fi
# first GOPATH only
my_append_path "${GOPATH%%:*}/bin"
# for all GOPATH
#PATH="${GOPATH//://bin:}/bin"
