my_reload_base=${0%/*}
my_reload () {
    local f
    for f in ${my_reload_base}/profile.d/*sh; do
	case "$f" in
	    *.sh|*.zsh)
		. $f
		;;
	esac
    done
    if [ -f "$HOME/.zshrc.$HOST" ]; then
	. "$HOME/.zshrc.$HOST"
    fi
}

my_reload
