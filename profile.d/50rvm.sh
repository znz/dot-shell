# lazy loading
rvm () {
    case "$(type ruby)" in
	*rbenv*)
	    echo "rbenv is enabled."
	    return 1
	    ;;
        *)
	    ;;
    esac
    if [ -n "$BASH_VERSION" -o -n "$ZSH_VERSION" ]; then
	unset -f rvm
	if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then
	    my_append_path "$HOME/.rvm/bin"
	    . "$HOME/.rvm/scripts/rvm"
	fi
	rvm "$@"
    else
	echo "$SHELL is not supported."
	return 1
    fi
}

# rbenv is not installed.
if [ ! -d $HOME/.rbenv ]; then
    if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then
	unset -f rvm
	my_append_path "$HOME/.rvm/bin"
	. "$HOME/.rvm/scripts/rvm"
    fi
fi
