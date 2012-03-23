#!/bin/zsh
my_dot_shell_dir=${0%/*}
for my_zshrc_file in ${my_dot_shell_dir}/profile.d/*sh(N-.); do
    case "$my_zshrc_file" in
	*.sh|*.zsh)
	    . "$my_zshrc_file"
	    ;;
    esac
done
unset my_zshrc_file

if [ -f "$HOME/.zshrc.$HOST" ]; then
    . "$HOME/.zshrc.$HOST"
fi

unset my_dot_shell_dir
