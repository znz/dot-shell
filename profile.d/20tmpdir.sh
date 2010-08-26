#!/bin/sh

my_tmpdir () {
    # libpam-tmpdir: "/tmp/user/$UID"
    # my default: "/tmp/.$USER.tmpdir"
    # my fallback: "$HOME/tmpdir"
    local d
    for d in "/tmp/user/$UID" "/tmp/.$USER.tmpdir" "$HOME/tmpdir"; do
        if [ ! -d "$d" ]; then
            mkdir -p "$d"
        fi
        if [ -O "$d" ]; then
            echo "$d"
            return 0
        fi
    done
    return 1
}

if [ -n "$TMPDIR" ]; then
    : # already set TMPDIR
elif is_cygwin; then
    TMPDIR=/tmp
else
    TMPDIR="`my_tmpdir`"
    if [ ! -O "$TMPDIR" ]; then
        unset TMPDIR
    fi
fi

if [ -n "$TMPDIR" ]; then
    export TMPDIR
fi
