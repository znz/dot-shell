#!/bin/zsh
function my-ignore-eof {
    if [[ -z "$BUFFER" ]]; then
	if [ "$WIDGET" != "$LASTWIDGET" ]; then
	    MY_IGNORE_EOF_COUNT=0
	fi
	if [[ ${IGNOREEOF:-10} -le $[MY_IGNORE_EOF_COUNT++] ]]; then
	    echo exit
	    BUFFER=" exit"
	    builtin zle .accept-line
	else
	    # echo "zsh: use 'exit' to exit." in next line
	    builtin zle .accept-line
	fi
    else
	builtin zle .delete-char-or-list
    fi
}
zle -N my-ignore-eof

bindkey '^D' my-ignore-eof
setopt ignoreeof
