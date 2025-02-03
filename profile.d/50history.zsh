#!/bin/zsh

# 履歴関係

# HISTSIZE=2000
# $SAVEHIST=1000
HISTSIZE=12345678
SAVEHIST=$HISTSIZE

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"

# migration
[[ -f "$HISTFILE" ]] || {
    sleep $[$RANDOM%10]
    mkdir -p $HISTFILE:h
    if [[ -f "$HOME/.zsh_history" ]]; then
        mv -vi "$HOME/.zsh_history" "$HISTFILE"
    elif [[ -f "$HOME/.config/shell/zhistory/$(print -P '%n.%M')" ]]; then
        mv -vi "$HOME/.config/shell/zhistory/$(print -P '%n.%M')" "$HISTFILE"
    fi
}

## 無ければ作る。
[ -d $HISTFILE:h ] || {
    echo mkdir -p $HISTFILE:h 1>&2
    mkdir -p $HISTFILE:h
}

setopt APPEND_HISTORY		# histを上書きではなく追加する。
#unsetopt EXTENDED_HISTORY	# タイムスタンプをつけるかどうか。
setopt HIST_ALLOW_CLOBBER	# >を>|としてhistに保存する。
unsetopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS		# 前の行と同じならhistに保存しない。
setopt HIST_IGNORE_SPACE	# 空白で始まっていたらhistに保存しない。
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY		# histの展開をした時直接実行しない。
setopt SHARE_HISTORY		# historyを別プロセスのzshと共有する。

function history-all { history -E 1 }
