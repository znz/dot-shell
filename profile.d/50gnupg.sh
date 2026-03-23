if [ ! -d ~/.gnupg ]; then
    export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
fi

if [ -x /opt/homebrew/bin/pinentry-mac ]; then
    if ! grep -q "pinentry-program /opt/homebrew/bin/pinentry-mac" "${GNUPGHOME:-"${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"}/gpg-agent.conf"; then
	install -m 700 -d "${GNUPGHOME:-"${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"}"
	echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> "${GNUPGHOME:-"${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"}/gpg-agent.conf"
	defaults write org.gpgtools.common UseKeychain NO
    fi
fi
