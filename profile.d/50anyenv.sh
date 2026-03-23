# use default if it already exists
if [ -d "$XDG_DATA_HOME/anyenv" ]; then
    export ANYENV_ROOT="$XDG_DATA_HOME/anyenv"
fi
if [ -d "${ANYENV_ROOT:-$HOME/.anyenv}" ]; then
    PATH="${ANYENV_ROOT:-$HOME/.anyenv}/bin:$PATH"
    eval "$(anyenv init - --no-rehash)"
fi

my_anyenv_init () {
    : "${ANYENV_ROOT:=$XDG_DATA_HOME/anyenv}"
    [ -d "$ANYENV_ROOT" ] || git clone --depth=1 https://github.com/anyenv/anyenv.git "$ANYENV_ROOT"
    export PATH="${ANYENV_ROOT:-$HOME/.anyenv}/bin:$PATH"
    eval "$(anyenv init -)"
    [ -d "${ANYENV_DEFINITION_ROOT:-${XDG_CONFIG_HOME:-${HOME}/.config}/anyenv/anyenv-install}" ] || anyenv install --force-init
    [ -d "$ANYENV_ROOT/plugins/anyenv-update" ] || git clone --depth=1 https://github.com/znz/anyenv-update.git "$ANYENV_ROOT/plugins/anyenv-update"
    [ -d "$ANYENV_ROOT/plugins/anyenv-git" ] || git clone --depth=1 https://github.com/znz/anyenv-git.git "$ANYENV_ROOT/plugins/anyenv-git"
    if [ ! -d "$ANYENV_ROOT/envs/rbenv" ]; then
	anyenv install rbenv
	eval "$(anyenv init -)"
    fi
    [ -d "$RBENV_ROOT/plugins/rbenv-plug" ] || git clone --depth=1 https://github.com/znz/rbenv-plug.git "$RBENV_ROOT/plugins/rbenv-plug"
    [ -d "$RBENV_ROOT/plugins/rbenv-aliases" ] || rbenv plug aliases
    [ -d "$RBENV_ROOT/plugins/rbenv-each" ] || rbenv plug each
}
