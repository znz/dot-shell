my_keychain_env () {
    local MY_UNAME_N="`uname -n`"
    local f

    # ssh-agent
    # keychain 2.0.0 or later: ~/.keychain/`uname -n`-sh
    # keychain 1.x: ~/.ssh-agent-`uname -n`
    for f in \
	"${HOME}/.keychain/${MY_UNAME_N}-sh" \
	"${HOME}/.ssh-agent-${MY_UNAME_N}" \
	; do
	if [ -r "$f" ]; then
	    . "$f"
	    break
	fi
    done

    # gpg-agent
    # keychain 2.4.0 or later: ~/.keychain/`uname -n`-sh-gpg
    for f in "${HOME}/.keychain/${MY_UNAME_N}-sh-gpg"; do
	if [ -r "$f" ]; then
	    . "$f"
	    break
	fi
    done
}

my_init_keychain () {
    if is_cygwin; then
        if ps | grep win-ssh-agent >/dev/null 2>&1; then
            return
        fi
    fi
    if [ -n "$SSH_AGENT_PID" ]; then
        if kill -0 "$SSH_AGENT_PID" >/dev/null 2>&1; then
            return
        fi
    fi
    find /tmp -maxdepth 1 -name ssh-\* -type d -uid "`id -u`" -perm 700 -exec /bin/rm -rfv -- '{}' \;
    find "$HOME/.ssh" -name "*id_[dr]sa" | xargs -t keychain
    my_create_cachedir_tag keychain "$HOME/.keychain"
    my_keychain_env
}

if type keychain >/dev/null 2>&1; then
    if [ -f "${HOME}/.ssh/id_dsa" -o -f "${HOME}/.ssh/id_rsa" ]; then
        my_init_keychain
    fi
fi
