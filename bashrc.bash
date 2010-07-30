my_reload () {
    local f
    for f in ${BASH_SOURCE[0]%/*}/profile.d/*.sh; do
	. $f
    done
}

my_reload
