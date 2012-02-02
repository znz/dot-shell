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

# save dirstack to ~/.cache/shell
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
touch "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
my_save_dirstack () {
    dirstack=(${(@u)$(<"${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack")})
    dirs -lp >! "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.dirstack"
}
chpwd_functions+=my_save_dirstack
my_save_dirstack

# collect shell's cwd
#if [ -L /proc/self/cwd ]; then
#    dirs ${(@u)$(pgrep -u $UID zsh | xargs -iPID readlink "/proc/PID/cwd")}
#fi
