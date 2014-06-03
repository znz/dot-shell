if [ -z "${GOPATH:-}" ]; then
    export GOPATH=$HOME/g
    PATH=$PATH:$GOPATH/bin
fi
