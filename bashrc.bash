my_reload () {
    local f
    my_dot_shell_dir="${BASH_SOURCE[0]%/*}"
    for f in "${my_dot_shell_dir}"/profile.d/*sh; do
	case "$f" in
	    *.sh|*.bash)
		. "$f"
		;;
	esac
    done
    unset my_dot_shell_dir
}

my_reload

