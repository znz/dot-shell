my_set_pager () {
    # see less(1)
    # -F: quit if one screen
    # -i: ignore case search
    # -M: moreより詳細なプロンプト
    # -q: visual bell
    # -R: ANSI の「カラー」エスケープシーケンスを考慮した、制御文字をそのまま表示
    # -X: lessを終了しても最後に表示している部分が残る。
    LESS=-FiMqRX
    export LESS

    # make less more friendly for non-text input files, see lesspipe(1)
    #[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
    if type /usr/bin/lesspipe >/dev/null 2>&1; then
	LESSOPEN="| /usr/bin/lesspipe '%s'"
	LESSCLOSE="/usr/bin/lesspipe '%s' '%s'"
	export LESSOPEN LESSCLOSE
    fi

    case $LANG in
	ja_JP.[Uu][Tt][Ff]*8) JLESSCHARSET=japanese-utf-8 ; LV=-cOu8 ;;
	ja_JP.SJIS)  JLESSCHARSET=japanese-sjis ;  LV=-cOs ;;
	ja*)	     JLESSCHARSET=japanese-euc ;   LV=-cOej ;;
	*)	     JLESSCHARSET=latin1 ;	   LV=-cAl1 ;;
    esac
    export JLESSCHARSET LV

    local IS_UTF8 IS_NOT_UTF8
    case "$LANG" in
	*[Uu][Tt][Ff]-8|*[Uu][Tt][Ff]8)
            IS_UTF8=:
            IS_NOT_UTF8=false
            ;;
	*)
            IS_UTF8=false
            IS_NOT_UTF8=:
    esac

    if [ -n "$PAGER" ]; then
	:
    elif $IS_NOT_UTF8 && type jless >/dev/null 2>&1; then
	PAGER=jless
	more () {
	    jless -E '-P?f--More-- (%pb\%):--More--.' "$@"
	}
	READNULLCMD=more
    elif type lv >/dev/null 2>&1; then
	PAGER=lv
	READNULLCMD=lv
	if type less >/dev/null 2>&1; then
	    export GIT_PAGER=less
	fi
    elif type less >/dev/null 2>&1; then
	PAGER=less
	more () {
	    less -E '-P?f--More-- (%pb\%):--More--.' "$@"
	}
	READNULLCMD=more
    elif type more >/dev/null 2>&1; then
	PAGER=more
	READNULLCMD=more
    fi

    if [ -n "$PAGER" ]; then
	export PAGER
    fi

    # READNULLCMD is zsh feature
    if [ -z "$ZSH_VERSION" ]; then
	unset READNULLCMD
    fi
}

if [ "${PAGER+set}" != set ]; then
    my_set_pager
fi
