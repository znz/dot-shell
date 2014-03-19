#!/bin/zsh

# echo ${(t)path} #=> array-unique-special
typeset -U path PATH

path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    $path(N-/^W)
)

bin_to_path () {
    # ./bin should be owned by me, and not group-writable nor world-writable.
    # ./bin/* should not be either.
    if [ -d "$(echo bin(Nu$UID-^IW))" -a -z "$(echo bin/*(NxI,xW))" ]; then
        path=(bin ${path:#bin})
    else
        path=(${path:#bin})
    fi
}
chpwd_functions+=bin_to_path
