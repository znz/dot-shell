# fix SHELL variable
# (mismatch when 'exec zsh' on bash)
if [ -n "$BASH_VERSION" -a "${SHELL##*/}" != "bash" ]; then
    SHELL=$(which bash)
elif [ -n "$ZSH_VERSION" -a "${SHELL##*/}" != zsh ]; then
    SHELL=$(which zsh)
fi
