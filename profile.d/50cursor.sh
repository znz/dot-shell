if [ "$TERM_PROGRAM" = "ghostty" ]; then
    # https://unix.stackexchange.com/questions/3759/how-to-stop-cursor-from-blinking
    # https://kmiya-culti.github.io/RLogin/ctrlcode.html#DECRST
    printf '\033[?12l'
fi
