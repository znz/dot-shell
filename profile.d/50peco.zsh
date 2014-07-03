if (( ${+commands[peco]} )); then
    # http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38#comment-374d8378994ca64ddad7
    #alias s='ssh $(awk 'tolower($1)=="host"{$1="";print}' ~/.ssh/config | xargs -n1 | egrep -v '[*?]' | sort -u | peco)'
fi
