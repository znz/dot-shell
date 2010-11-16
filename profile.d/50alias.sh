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

alias bell='echo -e "\a\c"'
if [ -x /usr/bin/paplay -a -f /usr/share/sounds/gnome/default/alerts/drip.ogg ]; then
    alias bell='/usr/bin/paplay /usr/share/sounds/gnome/default/alerts/drip.ogg'
fi
alias odx='od -A x -t x1z'

# ping
if is_cygwin; then
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

# ssh wrapper
ssh () {
    if [ $# -eq 1 ]; then
	# hostname only
	xtitle "$1"
    fi
    if [ -n "$TMPDIR" ]; then
	command ssh -o ControlMaster=auto -o "ControlPath=$TMPDIR/%r,%h,%p" "$@"
    else
	command ssh "$@"
    fi
}

euc_ssh () {
    if [ $# -eq 1 ]; then
	# hostname only
	xtitle "$1"
    fi
    if [ -n "$WINDOW" ]; then
	# in screen
	echo change euc
	screen -X encoding euc
	ssh "$@"
	screen -X encoding utf8
	echo revert to utf8
    else
	echo via cocot
	if [ -n "$TMPDIR" ]; then
	    env TERM=xterm cocot -t utf-8 -p euc-jp -- ssh -o ControlMaster=auto -o "ControlPath=$TMPDIR/%r,%h,%p" "$@"
	else
	    env TERM=xterm cocot -t utf-8 -p euc-jp -- ssh "$@"
	fi
    fi
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
