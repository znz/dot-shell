#!/bin/zsh
my_zshrc_base=${0%/*}
for my_zshrc_file in ${my_zshrc_base}/profile.d/*sh(N-.); do
    case "$my_zshrc_file" in
	*.sh|*.zsh)
	    . "$my_zshrc_file"
	    ;;
    esac
done
unset my_zshrc_base
unset my_zshrc_file

if [ -f "$HOME/.zshrc.$HOST" ]; then
    . "$HOME/.zshrc.$HOST"
fi
