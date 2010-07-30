if [ "${EDITOR+set}" != set ]; then
    for EDITOR in emacs vim vi; do
	if type "$EDITOR" >/dev/null 2>&1; then
            break
	fi
    done
fi

if [ -n "$EDITOR" ]; then
    export EDITOR
fi

: ${VISUAL:=vi}
export VISUAL
: ${CVSEDITOR:=$VISUAL}
export CVSEDITOR
: ${SVN_EDITOR:=$VISUAL}
export SVN_EDITOR
