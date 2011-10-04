# ls の動作 (属性表示、色つき)。man ls 参照
if [ x"$TTY" = x"/dev/conin" ]; then
    alias ls='ls --color=no'
elif [ "$TERM" = "dumb" -o "$TERM" = "emacs" ]; then
    alias ls='ls -F'
else
    case "`uname -s`" in
        *BSD*)
            if type gls >/dev/null 2>&1; then
                alias ls='gls -F --color=auto'
            else
                alias ls='ls -F'
            fi
            ;;
        Linux)
            alias ls='ls -F --color=auto'
            ;;
        Darwin)
            alias ls='ls -FG'
            ;;
        *)
            alias ls='ls -F'
            ;;
    esac
fi

## ls alias
alias l='ls -CF'
alias ll='ls -lA'
alias la='ls -a'

## from /etc/skel/.bashrc
alias dir='ls --format=vertical'
alias vdir='ls --format=long'

# List only directories and symbolic
# links that point to directories
if [ -n "$ZSH_VERSION" ]; then
    alias lsd='ls -ld *(-/DN)'
else
    alias lsd='ls -ld $(find . -maxdepth 1 -type d)'
fi

# List only file beginning with "."
alias lsa='ls -ld .*'
