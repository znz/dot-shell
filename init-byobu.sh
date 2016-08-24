#!/bin/bash
set -euxo pipefail
install -d "$HOME/.byobu"
cat <<EOF >"$HOME/.byobu/keybindings.tmux"
unbind-key -n C-a
unbind-key -n C-z
set -g prefix ^Z
set -g prefix2 ^Z
bind z send-prefix
EOF
SHELL=/bin/true byobu || :
sed -i -e 's/\([^#]\)logo/\1#logo/g' "$HOME/.byobu/status"
echo 'SHELL=/bin/zsh byobu' >>"$HOME/.bash_history"
