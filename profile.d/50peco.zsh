if (( ${+commands[peco]} )); then
  peco-find-file () {
    local selected_files
    selected_files="$(if git rev-parse 2>/dev/null; then
      git ls-files
    else
      find . -type f
    fi | peco --prompt '[find file]')"
    selected_files=("${(qf)selected_files}")
    BUFFER="${BUFFER}${selected_files}"
    CURSOR=$#BUFFER
    zle redisplay
  }
  zle -N peco-find-file
  bindkey '^[F' peco-find-file

  peco-go-to-dir () {
    local line
    local selected="$(
      {
        (
          autoload -Uz chpwd_recent_filehandler
          chpwd_recent_filehandler && for line in $reply; do
            if [[ -d "$line" ]]; then
              echo "$line"
            fi
          done
        )
        ghq list --full-path
        for line in *(-/) ${^cdpath}/*(N-/); do echo "$line"; done | sort -u
      } | peco --query "$LBUFFER"
    )"
    if [ -n "$selected" ]; then
      BUFFER="cd ${(q)selected}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-go-to-dir
  bindkey '^[g' peco-go-to-dir

  peco-select-history () {
    BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
  }
  zle -N peco-select-history
  bindkey '^[r' peco-select-history

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
