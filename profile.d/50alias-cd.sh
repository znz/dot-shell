alias .=source
alias ..='cd ..'

if [ -n "$ZSH_VERSION" ]; then
    alias -g ...=../..
    alias -g ....=../../..
    alias -g .....=../../../..
    alias -g ......=../../../../..
    alias -g .......=../../../../../..
    alias -g ........=../../../../../../..

    cd () {
        if [[ -f $1 ]]; then
            builtin cd $1:h
        else
            builtin cd $1
        fi
    }
else
    cd () {
        if [ -f "$1" ]; then
            builtin cd $(dirname "$1")
        else
            builtin cd "$@"
        fi
    }
fi

mkcd () {
    mkdir "$1" && cd "$1"
}

my_aliases_xdg () {
    local dir
    if type xdg-user-dir >/dev/null 2>&1; then
	if [ -f "$HOME/.config/user-dirs.dirs" ]; then
            for dir in $(sed -ne 's/^XDG_\(.*\)_DIR.*/\1/p' ~/.config/user-dirs.dirs); do
		alias cd2$dir="cd \$(xdg-user-dir $dir)"
            done
	fi
    fi
}
my_aliases_xdg
