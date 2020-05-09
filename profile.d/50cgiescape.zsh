autoload -U modify-current-argument

_cgiescape () {
    REPLY=$(ruby -r cgi/util -e 'puts CGI.escape ARGV.shift' -- "$1")
}

_cgiescape-region() {
    modify-current-argument _cgiescape
    zle vi-forward-blank-word
}
zle -N _cgiescape-region
bindkey '^[%' _cgiescape-region
