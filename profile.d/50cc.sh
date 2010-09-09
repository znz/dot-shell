my_set_cc () {
    local f
    for f in colorgcc gcc cc; do
        if type $f >/dev/null 2>&1; then
            CC="$f"
            export CC
            break
        fi
    done

    for f in g++; do
        if type $f >/dev/null 2>&1; then
            CXX="$f"
            export CXX
            break
        fi
    done

    if type distcc >/dev/null 2>&1; then
        local MY_DISTCC_HOSTS_FILE="$HOME/.config/shell/distcc.hosts"
        if [ -r "$MY_DISTCC_HOSTS_FILE" ]; then
            DISTCC_HOSTS="$(cat "$MY_DISTCC_HOSTS_FILE")"
            export DISTCC_HOSTS
            if type ccache >/dev/null 2>&1; then
                export CCACHE_PREFIX="distcc"
            else
                [ -n "$CC"  ] && CC="distcc $CC"
                [ -n "$CXX" ] && CXX="distcc $CXX"
            fi
        fi
    fi

    if type ccache >/dev/null 2>&1; then
        [ -n "$CC"  ] && CC="ccache $CC"
        [ -n "$CXX" ] && CXX="ccache $CXX"
    fi
}

# increase the cache-size
#ccache -M 10G

#export CC='ccache gcc' CXX='ccache g++'
if [ "${CC+set}" != set ]; then
    my_set_cc
fi
