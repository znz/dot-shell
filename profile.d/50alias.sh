## DOS like
alias cls=clear
alias dri=dir
alias idr=dir
alias del="rm -i"
alias md=mkdir
alias rd=rmdir

## short alias
#alias h=history
alias j=jobs
alias p='ruby -e "p ARGV" --'

alias bell='echo -e "\a\c"'

if [ -x /usr/bin/paplay -a -f /usr/share/sounds/gnome/default/alerts/drip.ogg -a -f /usr/share/sounds/gnome/default/alerts/glass.ogg ]; then
    alias bell_ok='/usr/bin/paplay /usr/share/sounds/gnome/default/alerts/drip.ogg'
    alias bell_ng='/usr/bin/paplay /usr/share/sounds/gnome/default/alerts/glass.ogg'
else
    alias bell_ok=bell
    alias bell_ng=bell
fi
alias odx='od -A x -t x1z'

# ping
if [ x$OSTYPE = xcygwin ]; then
    alias pin='ping -n 3'
else
    alias pin='ping -c 3'
fi

# GNU grep
alias grep='LANG=C grep --color'

# dig wrapper
digx () {
    dig +short -x $(dig +short "$1"|tee /dev/stderr)
}

# ps
alias psme="ps fuxwww"
alias pst='pstree -ahpu'
alias pstm="pstree -ahpu $USER"
alias topme='top -U `id -un`'

# one char alias for narrow band
alias S='screen -xR'
alias SS='exec screen -xR'

## PAGER
le () {
    case $# in
	# 0 is same as *
	#0)
	#    $PAGER
	#    ;;
	1)
	    if [ -d "$1" ]; then
		ls "$1"
	    else
		$PAGER "$@"
	    fi
	    ;;
	*)
	    $PAGER "$@"
	    ;;
    esac
}

sl () {
    if [ -n "$WINDOW" ]; then
	screen \sl "$@"
    else
	command sl "$@"
    fi
}

TT () {
    local session_name="${1:-0}"
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
    else
        tmux new-session -s "$session_name"
    fi
    return 0
}

eijiro () {
    # $PAGER は less か lv を想定
    w3m "http://eow.alc.co.jp/$*/UTF-8/" | $PAGER '+/検索文字列'
}

alias prevcmd="fc -nl -1 -1 | sed -e 's/^[[:space:]]*//'"
