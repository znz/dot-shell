#!/bin/sh

case `uname` in
    CYGWIN_*)
        is_cygwin () {
            :
        }
        is_not_cygwin () {
            false
        }
        # export MAKE_MODE=unix
        # unset TEMP TMP
        ;;
    *)
        is_cygwin () {
            false
        }
        is_not_cygwin () {
            :
        }
        ;;
esac
