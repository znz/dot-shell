tty_pwd_restore () {
    local tty_pwd="${XDG_CACHE_HOME:-$HOME/.cache}/shell/$(print -P '%l')".pwd
    if [ -f "$tty_pwd" ]; then
        cd $(<"$tty_pwd")
    fi
}
tty_pwd_restore
tty_pwd_save () {
    local tty_pwd="${XDG_CACHE_HOME:-$HOME/.cache}/shell/$(print -P '%l')".pwd
    pwd >"$tty_pwd"
}
chpwd_functions+=tty_pwd_save
