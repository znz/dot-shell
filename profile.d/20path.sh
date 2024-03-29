my_in_path_p () {
    local p path_
    p=$1
    path_=${2:-$PATH}
    case ":$path_:" in
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

my_prepend_path_before () {
    case ":$PATH:" in
	*:"$2":*:"$1":*|*:"$2":"$1":*)
	    ;;
	*:"$1":*:"$2":*|*:"$1":"$2":*)
	    PATH="$2:$PATH"
	    ;;
	*)
	    PATH="$2:$PATH"
	    ;;
   esac
   return 0
}

my_prepend_path_before /usr/bin /usr/local/bin
my_prepend_path_before /usr/sbin /usr/local/sbin
my_prepend_path /opt/local/bin
my_prepend_path /opt/local/sbin
if [ -d $HOME/opt ]; then
    my_append_path $HOME/opt/*/bin
fi

my_prepend_path $HOME/bin
if [ -d $HOME/homebrew/bin ]; then
    if [ -d $HOME/homebrew/sbin ]; then
	my_prepend_path $HOME/homebrew/sbin
    fi
    my_prepend_path $HOME/homebrew/bin
    my_prepend_path_before /usr/bin $HOME/homebrew/bin
fi

# Use newer bison (GPL 3+)
my_prepend_path /opt/homebrew/opt/bison/bin
