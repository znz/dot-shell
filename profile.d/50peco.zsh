if (( ${+commands[peco]} )); then
  peco-go-to-dir () {
    local line
    local selected=$(
      {
        ghq list --full-path
        (
          autoload -Uz chpwd_recent_filehandler
          chpwd_recent_filehandler && for line in $reply; do
            if [[ -d "$line" ]]; then
              echo "$line"
            fi
          done
        )
        for line in *(-/) ${^cdpath}/*(N-/); do echo "$line"; done
      } | sort -u | peco --query "$LBUFFER"
    )
    if [ -n "$selected" ]; then
      BUFFER="cd ${selected}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-go-to-dir
  bindkey '^[g' peco-go-to-dir

  # http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38#comment-374d8378994ca64ddad7
  #alias s='ssh $(awk 'tolower($1)=="host"{$1="";print}' ~/.ssh/config | xargs -n1 | egrep -v '[*?]' | sort -u | peco)'
  peco-ssh () {
    local selected=$(awk 'tolower($1)=="host"{$1="";print}' ~/.ssh/config | xargs -n1 | egrep -v '[*?]' | sort -u | peco --query "$LBUFFER")
    if [ -n "$selected" ]; then
      BUFFER="ssh ${selected}"
    fi
    zle clear-screen
  }
  zle -N peco-ssh
  bindkey '^[s' peco-ssh
fi
