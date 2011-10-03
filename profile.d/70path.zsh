#!/bin/zsh

# echo ${(t)path} #=> array-unique-special
typeset -U path PATH

path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    $path(N-/^W)
)
