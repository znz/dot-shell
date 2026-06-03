() {
    if (( ${+commands[rustup]} )); then
	local _rustup="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/functions/_rustup"
	mkdir -p "${_rustup:h}"
	if [[ -z $(echo ${_rustup}(N.mh-24)) ]]; then
	    rustup completions zsh > "${_rustup}"
	fi
	fpath=("${_rustup:h}" $fpath)
    fi
}
