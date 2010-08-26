#!/bin/zsh
# bindkey -v             # vi key bindings
bindkey -e               # emacs key bindings
bindkey ' ' magic-space  # also do history expansion on space

# vi の % や emacs の match-paren (検索すると見つかる) と同じ
bindkey '^X%' vi-match-bracket
