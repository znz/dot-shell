# etchのlanguage-envの.bashrcを参考にした。
## debianでは xprop は、xbase-clients パッケージに含まれます
#if [ -n "$WINDOWID" -a -x /usr/bin/X11/xprop ] ; then
#    # X Window System 上で走ってるけど X Window System と通信する権限が
#    # ないとき (su したときなど) への対策
#    xprop -id $WINDOWID >/dev/null 2>&1 || unset WINDOWID
#fi
if [ -n "$WINDOWID" -a -x /usr/bin/xprop ] ; then
    xprop -id $WINDOWID >/dev/null 2>&1 || unset WINDOWID
fi
