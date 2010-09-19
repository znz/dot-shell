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
