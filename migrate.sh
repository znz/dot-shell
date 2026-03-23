#!/bin/zsh
# Migrate to XDG dirs

set -euo pipefail

() { # (Re-)start gpg-agent
    gpgconf --kill gpg-agent
    local GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
    # migration
    if [[ ! -d $GNUPGHOME ]] && [[ -d $HOME/.gnupg ]]; then
        mv -vi $HOME/.gnupg $GNUPGHOME
        export GNUPGHOME
    fi
    gpg -K &>/dev/null
}
