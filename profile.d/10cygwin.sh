#!/bin/sh

case `uname` in
    CYGWIN_*)
        alias is_cygwin=:
        alias is_not_cygwin=false
        # export MAKE_MODE=unix
        # unset TEMP TMP
        ;;
    *)
        alias is_cygwin=false
        alias is_not_cygwin=:
        ;;
esac
