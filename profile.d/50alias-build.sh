configure_at_here () {
    ./configure --prefix=$HOME/opt/$(basename $(pwd)) "$@"
}

# automakeとかを使っているものをbuildしなおすときにautoconfだけを使ってはいけない。
autoconf () {
    local f
    for f in autogen.sh bootstrap; do
        if [ -f "$f" ]; then
            echo "use ./$f instead of autoconf" 1>&2
            return 1
        fi
    done
    command autoconf "$@"
}

gcc_macros () {
    gcc -E -dM -xc /dev/null
}

Log () {
    "$@" 2>&1 | tee _"$(echo "$@" | tr ' ' '_')".log
    # PIPESTATUS for bash
    # pipestatus for zsh
    return $(( ${PIPESTATUS[0]:-0} + ${pipestatus[1]:-0} ))
}

init_git_info () {
    if [ ! -d .git/info ]; then
        echo ".git/info/ not found."
        return
    fi
    if ! grep -q ChangeLog .git/info/attributes 2>/dev/null; then
        echo "ChangeLog merge=merge-changelog" >> .git/info/attributes
    fi
}
