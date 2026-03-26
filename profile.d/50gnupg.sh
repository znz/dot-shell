if [ -d "${GNUPGHOME:-${XDG_DATA_HOME:-$HOME/.local/share}/gnupg}" ]; then
    export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
fi
