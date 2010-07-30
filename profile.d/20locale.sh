if [ -n "$SSH_CLIENT" -a -z "$SSH_TTY" ]; then
    LANG=C
fi

export LANG

#LC_CTYPE=C; export LC_CTYPE
#LC_TIME=C; export LC_TIME
#LC_COLLATE=C; export LC_COLLATE

#unset LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
#unset LC_ALL
#unset LINGUAS
#unset LANGUAGE

# perl がロケールにかんするワーニングを出す場合に有効にしてください。
# PERL_BADLANG=0 ; export PERL_BADLANG
