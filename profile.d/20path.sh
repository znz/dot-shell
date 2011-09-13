my_in_path_p () {
    local p path
    p=$1
    path=${2:-$PATH}
    case ":$path:" in
	*:"$p":*)
	    return 0
	    ;;
	*)
	    ;;
    esac
    return 1
}

my_prepend_path () {
    local p
    for p in "$@"; do
	if ! my_in_path_p "$p"; then
	    if [ -d "$p" ]; then
		PATH="$p:$PATH"
	    fi
	fi
    done
}

my_append_path () {
    local p
    for p in "$@"; do
	if ! my_in_path_p $p; then
	    if [ -d "$p" ]; then
		PATH="$PATH:$p"
	    fi
	fi
    done
}

my_prepend_path /opt/local/bin
my_prepend_path /opt/local/sbin
if [ -d $HOME/opt ]; then
    my_prepend_path $HOME/opt/*/bin
fi
my_prepend_path $HOME/bin
# MacPorts and easy_install-2.7
my_append_path /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin
