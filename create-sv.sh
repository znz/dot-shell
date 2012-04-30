#!/bin/sh
NAME="$1"
if [ -z "$NAME" ]; then
    echo "usage: $0 name"
    exit 1
fi
set -ex
cd /etc/sv

if [ ! -f /etc/sv/log-run ]; then
    cat >/etc/sv/log-run <<'EOF'
#!/bin/sh
loguser=uucp
logdir="/var/log/runit/$(basename $(dirname $(pwd)))"
umask 027
if [ ! -d /var/log/runit ]; then
    mkdir -p /var/log/runit
    chown "$loguser:adm" /var/log/runit
fi
chpst -u "$loguser:adm" mkdir -p "$logdir"
cd "$logdir"
exec chpst -u "$loguser:adm" svlogd -tt "$logdir"
EOF
    chmod +x /etc/sv/log-run
fi

mkdir -p "$NAME"/log
ln -snf ../../log-run "$NAME"/log/run
ln -snf /var/run/sv."$NAME" "$NAME"/supervise
ln -snf /var/run/sv."$NAME".log "$NAME"/log/supervise
cat >"$NAME"/run <<'EOF'
#!/bin/sh
exec 2>&1
logger -s -t runsv -- start "$(basename $(pwd))"
USER=user
cd "/home/$USER"
exec chpst -u "$USER" prog
EOF
chmod +x "$NAME"/run
