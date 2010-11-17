#!/bin/zsh
# vim:set fileencoding=utf-8:

if [ -n "$WINDOW" ]; then
    # cds WINDOW number of screen, chdir to screen children directories.
    # otherwise chdir to argument.
    cds () {
        local sibling_pid win
        if [[ $1 = [0-9]* ]]; then
            for sibling_pid in $(pgrep -P $PPID); do
                win=${${(M)${(0)"$(</proc/$sibling_pid/environ)"}:#WINDOW=*}#WINDOW=}
                if [[ $1 -eq $win ]]; then
                    builtin cd $(readlink "/proc/$sibling_pid/cwd")
                    return $?
                fi
            done
        else
            builtin cd "$@"
        fi
    }

    # complete directories of sibling processes in screen"
    # screenで開いている他のシェルなどのディレクトリを補完
    _cds () {
        local expl list lines disp sep
        zstyle -s ":completion:${curcontext}:screen-children-directories" list-separator sep || sep=--
        local abs_pwd sibling_pid sibling_dir win
        local s_dirs
        typeset -A s_dirs
        if zstyle -T ":completion:${curcontext}:screen-children-directories" ignore-pwd; then
            abs_pwd=$(pwd -P)
        fi
        for sibling_pid in $(pgrep -P $PPID); do
            if [[ $$ == $sibling_pid ]]; then
                continue
            fi
            sibling_dir=$(readlink "/proc/$sibling_pid/cwd")
            if [[ "$abs_pwd" != "$sibling_dir" ]]; then
                #win=${${(M)${(0)"$(</proc/$sibling_pid/environ)"}:#WINDOW=*}#WINDOW=}
                win=${${(M)${(ps:\0:)"$(</proc/$sibling_pid/environ)"}:#WINDOW=*}#WINDOW=}
                s_dirs[$win]=$sibling_dir
            fi
        done
        list=(${(nk)s_dirs[@]})
        lines=()
        disp=()
        if zstyle -T ":completion:${curcontext}:screen-children-directories" verbose; then
            for win in $list; do
                lines+="$win $sep ${s_dirs[$win]}"
            done
            disp=( -ld lines )
        fi
        _wanted -V screen-children-directories expl 'screen children directories' \
            compadd "$@" "$disp[@]" -Q -a list
    }
    compdef _cds cds
fi

# Local Variables:
# coding: utf-8
# indent-tabs-mode: nil
# End:
