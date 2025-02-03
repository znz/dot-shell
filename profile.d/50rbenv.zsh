if [[ -n "$RBENV_ROOT" ]]; then
    fpath+=($RBENV_ROOT/completions)
fi

# echo ${(M)${(f)"$(rbenv install -l)"}:#[0-9]*} | xargs -n 1 rbenv install
rbenv-install-stable () {
    local v
    for v in $(rbenv install -l | grep -E '^[[:digit:]]'); do
        [[ -d "$RBENV_ROOT/versions/$v" ]] || rbenv install "$v"
    done
}
