convert-utf8-mac () {
    BUFFER=$(echo "$BUFFER" | iconv -f utf8 -t utf8-mac)
}
zle -N convert-utf8-mac
bindkey '^X"' convert-utf8-mac
