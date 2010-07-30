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

if type keychain >/dev/null 2>&1; then
    my_keychain_env
fi
