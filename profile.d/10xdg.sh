: ${XDG_CACHE_HOME:=~/.cache}; export XDG_CACHE_HOME
: ${XDG_CONFIG_HOME:=~/.config}; export XDG_CONFIG_HOME
: ${XDG_DATA_HOME:=~/.local/share}; export XDG_DATA_HOME
: ${XDG_STATE_HOME:=~/.local/state}; export XDG_STATE_HOME
case "$OSTYPE" in
    darwin*)
        : ${XDG_RUNTIME_DIR:=$(getconf DARWIN_USER_TEMP_DIR)}; export XDG_RUNTIME_DIR
        alias emacsclient='env -u XDG_RUNTIME_DIR emacsclient'
        ;;
esac
