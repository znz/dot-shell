my_reload () {
    local f
    for f in ${BASH_SOURCE[0]%/*}/profile.d/*sh; do
	case "$f" in
	    *.sh|*.bash)
		. $f
		;;
	esac
    done
}

my_reload
