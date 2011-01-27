#!/bin/zsh

# 履歴関係
DIRSTACKSIZE=50
setopt AUTO_CD                  # ディレクトリ名でcdできる。
setopt AUTO_PUSHD               # cd に pushd のような振る舞いをさせる。
unsetopt CDABLE_VARS            # foo=/tmp;cd fooで/tmpにcdできる。
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS              # +と-の意味を入れ替える。
setopt PUSHD_SILENT             # pushdやpopdの度にdirstackを表示しない。
setopt PUSHD_TO_HOME            # 引数無しのpushdをpushd $HOMEと同じようにする。

if [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack" ]; then
    dirs $(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")
fi

mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
my_save_dirstack () {
    dirs >| "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
}
chpwd_functions+=my_save_dirstack

if [ -L /proc/self/cwd ]; then
    dirs ${(@u)$(pgrep -u $UID zsh | xargs -iPID readlink "/proc/PID/cwd"; dirs)}
fi
