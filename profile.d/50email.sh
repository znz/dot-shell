EMAIL="mbf.nifty.com"
EMAIL='@'"$EMAIL"
EMAIL="zn""$EMAIL"
export EMAIL

if [ -f /etc/debian_version ]; then
    export DEBFULLNAME="Kazuhiro NISHIYAMA"
    DEBEMAIL="$EMAIL"
    export DEBEMAIL
fi
