if type ionice >/dev/null 2>&1; then
    alias git="ionice -c3 git"
fi
