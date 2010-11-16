#!/bin/zsh

watch=all
# 起動したコマンドの「ユーザ消費時間+システム消費時間」が $REPORTTIME 秒よりも
# 大きいときに time 内部コマンドを指定したのと同じ情報が表示される。
# (zshの本 p.246 参照)
REPORTTIME=1

setopt PRINT_EXIT_VALUE
unsetopt PROMPT_CR
setopt PROMPT_SUBST

my_precmd_beep () {
    # 長時間かかるコマンドの終了を通知
    # [ $TTYIDLE -gt 10 ] && echo "\aTTYIDLE=$TTYIDLE"
    # bell は echo "\a" のようなものの alias
    local exit_status="$(print -P '%?')"
    if [ $TTYIDLE -gt 10 -a $TTYIDLE -lt 86400 ]; then
	if [ 0 -eq $exit_status ]; then
	    bell_ok &!
	else
	    bell_ng &!
	fi
    fi
}
precmd_functions=(my_precmd_beep)

typeset -ga precmd_functions

my_psvar_init () {
    psvar=()
    my_psvar_color_index=1
    my_psvar_vcs_info_index=2
    psvar[$my_psvar_color_index]=0
}
my_psvar_init

my_precmd_prompt_color () {
    # プロンプトの色の変化。
    psvar[$my_psvar_color_index]=$[32+($psvar[$my_psvar_color_index]-30)%5]
}
precmd_functions+=my_precmd_prompt_color

my_vcs_info_init () {
    [[ -n ${(M)fpath:#*/VCS_Info*} ]] || return
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' formats '(%s)-[%b] '
    zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a] '
    if whence locale >/dev/null && [[ -n ${(M)$(locale -a):#en_US.utf8} ]]; then
        my_vcs_info () {
            LANG=en_US.UTF-8 vcs_info "$@"
            psvar[$my_psvar_vcs_info_index]="$vcs_info_msg_0_"
        }
    else
        my_vcs_info () {
            LANG=C vcs_info "$@"
            psvar[$my_psvar_vcs_info_index]="$vcs_info_msg_0_"
        }
    fi
    precmd_functions+=my_vcs_info
}
my_vcs_info_init

my_prompt_init () {
    local MY_OS_MARK_S MY_OS_MARK_L MY_OS_VERSION
    if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        MY_OS_MARK_S="$DISTRIB_ID"
        MY_OS_MARK_L="$DISTRIB_DESCRIPTION"
        MY_OS_VERSION="$DISTRIB_RELEASE"
        unset DISTRIB_ID
        unset DISTRIB_RELEASE
        unset DISTRIB_CODENAME
        unset DISTRIB_DESCRIPTION
    else
        case "$OSTYPE" in
            cygwin)
                MY_OS_MARK_L=Cygwin
                MY_OS_VERSION="${$(uname -r)%%[^[:digit:].]*}"
                ;;
            linux*)
                if [ -f /etc/debian_version ]; then
                    MY_OS_MARK_L="Debian GNU/Linux"
                    MY_OS_VERSION=${$(</etc/debian_version)%/*}
                    # /etc/debian_versionの例:
                    # 3.0
                    # 3.1
                    # 4.0
                    # lenny/sid
                elif [ -f /etc/gentoo-release ]; then
                    # /etc/gentoo-releaseの例:
                    # Gentoo Base System version 1.6.14
                    MY_OS_MARK_L="Gentoo Linux"
                    MY_OS_VERSION=${"$(</etc/gentoo-release)"//[^[:digit:].]}
                elif [ -f /etc/redhat-release ]; then
                    MY_OS_MARK_L=${"$(</etc/redhat-release)"% release*}
                    MY_OS_MARK_S=${MY_OS_MARK_L//[^A-Z]}
                    # 「Red Hat Linux release 9 (Shrike)」のような文字列から
                    # 数字と'.'だけを取り出す。
                    MY_OS_VERSION=${"$(</etc/redhat-release)"//[^[:digit:].]}
                    # /etc/redhat-releaseの例:
                    # Red Hat Linux release 9 (Shrike)
                    # Fedora Core release 2 (Tettnang)
                elif [ -f /etc/vine-release ]; then
                    MY_OS_MARK_L=${"$(</etc/vine-release)"% [0-9]*}
                    MY_OS_MARK_S=${MY_OS_MARK_L/ Linux/}
                    MY_OS_VERSION=${"$(</etc/vine-release)"//[^[:digit:].]}
                    # /etc/vine-releaseの例:
                    # Vine Linux 4.1 (Cos d'Estournel)
                else
                    MY_OS_MARK_L="$(uname)"
                    MY_OS_VERSION="$(uname -r)"
                fi
                ;;
            *)
                MY_OS_MARK_L="$(uname)"
                MY_OS_VERSION="${$(uname -r)%%[^[:digit:].]*}"
                ;;
        esac
        # 一番左の単語だけ取り出す。
        : ${MY_OS_MARK_S=${MY_OS_MARK_L%%[^A-Za-z]*}}
    fi

    if [ x"$MY_OS_MARK_L" != x"Cygwin" ]; then
        # コマンドプロンプトなどでまずいのでcygwinではつけない。
        RESET_ISO_2022=""
    fi
    local MY_OS=${MY_OS_MARK_S:-$MY_OS_MARK_L[0,3]}${MY_OS_VERSION:+"/$MY_OS_VERSION"}
    case $TERM in
        vt100|[Exk]term*|rxvt)
            MY_XTITLE='%m%% '
            ;;
        screen)
            MY_XTITLE=""
            ;;
    esac

    # エスケープシーケンス用。
    # バイナリを埋め込まなくても良いようにprintで生成。
    local ESC=$(print -Pn '\e')
    # エディタで括弧の対応がわかりにくくなるので変数に入れておく。
    local ESCX=$(print -Pn '\e[')
    # バイナリファイルをcatしてしまったときなどに
    # ISO-2022-JPのASCIIに戻すためのエスケープシーケンス。
    # 本当はTERM環境変数で対応している端末の時だけつけるべきだが、
    # GNU screenの中だと外が何なのかわからないので、ダメな環境だけ
    # 除外している。
    local RESET_ISO_2022=$(print -Pn '\e(B')

    # 直前のコマンドの終了ステータスが0以外のときは赤くする。
    # ${MY_MY_PROMPT_COLOR}はprecmdで変化させている数値。
    local MY_COLOR="$ESCX%(0?.%${my_psvar_color_index}v.31)m"
    local NORMAL_COLOR="$ESCX"m

    # %n: $USERNAME
    # %m: '.'の前までのホスト名
    local MY_PROMPT_BODY='%n@%m'
    # sshの接続元
    MY_PROMPT_BODY+="${SSH_CLIENT:+!${SSH_CLIENT%% *}}"
    # %%: %
    MY_PROMPT_BODY+='%%'
    # 上で調べたOSの情報
    MY_PROMPT_BODY+="$MY_OS"
    # %d: カレントディレクトリ
    # %~なら~/binなどに省略される。
    MY_PROMPT_BODY+=':%d'
    MY_PROMPT_BODY+=' '

    # rvmの情報
    if type __rvm_environment_identifier >/dev/null; then
	MY_PROMPT_BODY+='$(__rvm_environment_identifier) '
    fi

    # vcs_info (my_vcs_info_init 参照)
    if whence my_vcs_info >/dev/null; then
        MY_PROMPT_BODY+="%${my_psvar_vcs_info_index}v"
    fi

    # %L: $SHLVL
    # 2以上の時にS2やS3のように埋め込む。
    MY_PROMPT_BODY+='%(2L.S%L .)'
    # %j: jobs数
    # 1以上の時にj1やj2のように埋め込む。
    MY_PROMPT_BODY+='%(1j.j%j .)'
    # %l: ttyを短くした文字列(/dev/または/dev/ttyの省略)
    # /dev/pts/0ならpts/0、/dev/tty1なら1など。
    MY_PROMPT_BODY+='%l'
    # WINDOW環境変数: GNU screenのwindow番号
    # s0やs1のように埋め込む。
    MY_PROMPT_BODY+="${WINDOW:+" s$WINDOW"}"
    MY_PROMPT_BODY+=' '
    # %D %*: 現在日時
    MY_PROMPT_BODY+='%D %*'
    # %?: 直前のコマンドの終了ステータス
    # 0以外の時に埋め込む。
    MY_PROMPT_BODY+='%(0?.. %?)'
    # %{ ... %}: (表示されるプロンプトとしての)幅のないバイト列
    # %B ... %b: 太字
    # %U ... %u: 下線
    # %#: '%'または'#'
    PROMPT='%{'$RESET_ISO_2022$MY_COLOR'%}%B%#%{'$NORMAL_COLOR'%} %b'
    # %$[$COLUMNS - 5]<...<: これ以降の部分が $COLUMNS - 5 より長くならない。
    # 長くなった時は
    # 「% _<.../path/to/cur/dir some other info>」(_はカーソル位置)
    # のように省略されて、$COLUMNS - 5の長さになる。
    RPROMPT='%{'$MY_COLOR'%}%B<%U%$[$COLUMNS - 5]<...<'$MY_PROMPT_BODY'%u%{'$MY_COLOR'%}>%{'$NORMAL_COLOR'%}%b'
    #RPROMPT='<%U%n@%m:%~%u>'
}
my_prompt_init

my_precmd_prompt_title () {
    # 端末のタイトル設定
    # screen -X title $0:t
    my_prompt_title $0:t "$PWD"
}
precmd_functions+=my_precmd_prompt_title
