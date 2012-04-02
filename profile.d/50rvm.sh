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
	    . "$HOME/.rvm/scripts/rvm"
	fi
	rvm "$@"
    else
	echo "$SHELL is not supported."
	return 1
    fi
}
