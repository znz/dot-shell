#!/bin/zsh

# echo ${(t)path} #=> array-unique-special
typeset -U path PATH

path=(
    # reject world-writable directories
    $path(N^W)
)
