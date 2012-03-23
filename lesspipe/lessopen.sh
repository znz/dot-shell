#!/bin/sh
if type source-highlight >/dev/null 2>&1 ; then
    : ${SOURCE_HIGHLIGHT_STYLE:=--style-file=esc.style}
    if source-highlight --lang-list | egrep -e "^${1#*.} " >/dev/null 2>&1 ; then
        exec source-highlight --failsafe --infer-lang -f esc $SOURCE_HIGHLIGHT_STYLE -i "$1"
    fi
    case "$1" in
        *ChangeLog|*changelog)
            exec source-highlight --failsafe -f esc --lang-def=changelog.lang $SOURCE_HIGHLIGHT_STYLE -i "$1" ;;
        *Makefile|*makefile)
            exec source-highlight --failsafe -f esc --lang-def=makefile.lang $SOURCE_HIGHLIGHT_STYLE -i "$1" ;;
        /var/log/*.gz)
            zcat "$1" | source-highlight --failsafe -f esc --lang-def=log.lang $SOURCE_HIGHLIGHT_STYLE ;;
        /var/log/*)
            exec source-highlight --failsafe -f esc --lang-def=log.lang $SOURCE_HIGHLIGHT_STYLE -i "$1" ;;
        *)
            exec lesspipe "$@" ;;
    esac
else
    exec lesspipe "$@"
fi
