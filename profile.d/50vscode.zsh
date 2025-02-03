[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
if [ -n "$VSCODE_INJECTION" ]; then
    export EDITOR='code --wait'
fi
