#!/bin/zsh
# This script is intended to be run immediately after logging in.
set -euo pipefail

[ $(uname -s) = Darwin ]

# if ! ssh-add -l &>/dev/null; then
#     ssh-add ~/.ssh/id_ed25519 ~/.ssh/*/id_ed25519
# fi

() { # Create $HOME/.zshenv
    zshenv=$HOME/.zshenv
    [[ -f $zshenv ]] || touch $zshenv
    grep -q SHELL_SESSIONS_DISABLE=1 $zshenv || echo SHELL_SESSIONS_DISABLE=1 >> $zshenv
    grep -q ZDOTDIR= $zshenv || echo 'ZDOTDIR=${XDG_CONFIG_HOME:=~/.config}/zsh' >> $zshenv
}

() { # create $ZDOTDIR/.zshrc
    zshrc="${XDG_CONFIG_HOME:=~/.config}/zsh/.zshrc"
    [[ -d ${zshrc:h} ]] || mkdir -p ${zshrc:h}
    [[ -f $zshrc ]] || echo ". $(cd $(dirname "$0") && pwd)/zshrc.zsh" > $zshrc
}

() { # (Re-)start gpg-agent
    gpgconf --kill gpg-agent
    if [ -x /opt/homebrew/bin/pinentry-mac ]; then
	if ! grep -q "pinentry-program /opt/homebrew/bin/pinentry-mac" "${GNUPGHOME:-${XDG_DATA_HOME:-$HOME/.local/share}/gnupg}/gpg-agent.conf"; then
	    install -m 700 -d "${GNUPGHOME:-${XDG_DATA_HOME:-$HOME/.local/share}/gnupg}"
	    echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> "${GNUPGHOME:-${XDG_DATA_HOME:-$HOME/.local/share}/gnupg}/gpg-agent.conf"
	    defaults write org.gpgtools.common UseKeychain NO
	fi
    fi
    gpg -K &>/dev/null
}

if ! test -f /etc/pam.d/sudo_local; then
    sudo cp /etc/pam.d/sudo_local{.template,}
    sudo -e /etc/pam.d/sudo_local
fi

## colima

# colima start --cpu 4 --disk 100 --memory 12 --vm-type vz --vz-rosetta
# colima start --cpu 4 --disk 100 --memory 2 --vm-type qemu --mount-type 9p
colima start --cpu 4 --disk 100 --memory 8 --vm-type vz
#json=$(colima ssh cat /etc/docker/daemon.json | jq '.["registry-mirrors"] |= (.+["https://mirror.gcr.io"] | unique)') sh -c 'if [ -n "$json" ]; then echo "$json" | colima ssh sudo tee /etc/docker/daemon.json; fi'
#colima ssh sudo systemctl restart docker

docker pull --platform=linux/amd64 ghcr.io/ruby/all-ruby
docker pull --platform=linux/amd64 rubylang/all-ruby
# docker run --rm -it quay.io/podman/hello

## lima

if [[ -d ~/.lima/default ]]; then
    limactl start default
else
    limactl start --name=default template:ubuntu-lts
fi

(cd ~/s/github.com/znz/ansible-playbook-2022 && git pull --rebase --autostash --prune && rake lima:all)

## brew

# brew upgrade

# brew services start syncthing

# brew services start ollama
# brew services stop ollama

# launchctl unload ~/Library/LaunchAgents/com.zabbix.agentd.plist
# launchctl load -w ~/Library/LaunchAgents/com.zabbix.agentd.plist

## rust

if (( ${+commands[rustup]} )); then
    rustup update
fi

## anyenv

if (( ${+commands[anyenv]} )); then
    anyenv update
fi

if (( ${+commands[rbenv]} )); then
    # echo ${(M)${(f)"$(rbenv install -l)"}:#[0-9]*} | xargs -n 1 rbenv install
    bash -eux <<'EOF'
rbenv-install-stable () {
    local v
    for v in $(rbenv install -l | grep -E '^[[:digit:]]'); do
        [[ -d "$RBENV_ROOT/versions/$v" ]] || rbenv install "$v"
    done
}
rbenv-install-stable
EOF
fi

## URLs
