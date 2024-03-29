tty_pwd_file () {
    echo "${XDG_CACHE_HOME:-$HOME/.cache}/shell/${$(print -P '%l')/\//-}.pwd"
}

tty_pwd_restore () {
    local tty_pwd="$(tty_pwd_file)"
    if [ -f "$tty_pwd" ]; then
        cd $(<"$tty_pwd")
    fi
}

tty_pwd_save () {
    local tty_pwd="$(tty_pwd_file)"
    if [ "$HOME" = "$PWD" ]; then
        rm -f "$tty_pwd"
    else
        pwd >"$tty_pwd"
    fi
}

if [[ "$TERM_PROGRAM" =~ "Apple_Terminal|iTerm.app" ]]; then
    :
elif [ "$HOME" = "$PWD" ]; then
    tty_pwd_restore
    chpwd_functions+=tty_pwd_save
fi
