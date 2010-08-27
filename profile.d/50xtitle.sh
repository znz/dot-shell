#!/bin/sh

case $TERM in
    vt100|[Exk]term*|rxvt)
        MY_XTITLE_LEFT="\e]0;"
        MY_XTITLE_RIGHT="\a"
        my_prompt_title () {
            xtitle "$@"
        }
        ;;
    screen)
        MY_XTITLE_LEFT="\ek"
        MY_XTITLE_RIGHT="\e\\"
        MY_XXTITLE_LEFT="\eP\e]0;"
        MY_XXTITLE_RIGHT="\a\e\\"
        if [ -n "$SSH_CLIENT" -o -n "$SSH_CONNECTION" ]; then
            MY_XTITLE_LEFT="$MY_XTITLE_LEFT$HOST%%"
        fi
        my_prompt_title () {
            xtitle "$1"
        }
        ;;
    linux)
        # コンソールでは意味がないので何もしない。
        my_prompt_title () {
            :
        }
        ;;
    eterm-color)
        my_prompt_title () {
            # ignore "$@"
            echo -e "\033AnSiTu" $(whoami)
            echo -e "\033AnSiTc" $(pwd)
            echo -e "\033AnSiTh" $(hostname -f)
        }
        unset STY
        ;;
    *)
        MY_XTITLE_LEFT="\033]0;"
        MY_XTITLE_RIGHT="\007\c"
        my_prompt_title () {
            xtitle "$@"
        }
        ;;
esac

if [ -n "$STY" ]; then
    # in screen
    MY_XTITLE_LEFT="\ek"
    MY_XTITLE_RIGHT="\e\\"
    MY_XXTITLE_LEFT="\eP\e]0;"
    MY_XXTITLE_RIGHT="\a\e\\"
    my_prompt_title () {
        xtitle "$1"
    }
fi

if [ -n "$ZSH_VERSION" ]; then
    xtitle_normal () {
        print -Pn -- "\e]0;"
        print -n -- "$@"
        print -Pn -- "\a"
    }
    xtitle () {
        print -Pn -- "$MY_XTITLE_LEFT$MY_XTITLE"
        print -n -- "$@"
        print -Pn -- "$MY_XTITLE_RIGHT"
    }
    xxtitle () {
        print -Pn -- "${MY_XXTITLE_LEFT-$MY_XTITLE_LEFT}$MY_XTITLE"
        print -n -- "$@"
        print -Pn -- "${MY_XXTITLE_RIGHT-$MY_XTITLE_RIGHT}"
    }
    # for screen hardstatus
    xtitle_hstatus () {
        print -Pn -- "\e]0;$MY_XTITLE"
        print -n -- "$@"
        print -Pn -- "\a"
    }
    # for screen hardstatus only
    xtitle_hstatus2 () {
        print -Pn -- "\e_$MY_XTITLE"
        print -n -- "$@"
        print -Pn -- "\e\\"
    }
else
    xtitle () {
        echo -e "$MY_XTITLE_LEFT$MY_XTITLE$*$MY_XTITLE_RIGHT"
    }
    xxtitle () {
        echo -e "${MY_XXTITLE_LEFT-$MY_XTITLE_LEFT}$MY_XTITLE$*${MY_XXTITLE_RIGHT-$MY_XTITLE_RIGHT}"
    }
    xtitle_hstatus () {
        echo -e "\e]0;$MY_XTITLE$*\a"
    }
fi
