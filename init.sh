#!/bin/zsh
# This script is intended to be run immediately after logging in.
set -euo pipefail

[ $(uname -s) = Darwin ]

if ! ssh-add -l &>/dev/null; then
    ssh-add ~/.ssh/id_ed25519 ~/.ssh/*/id_ed25519
fi

gpg -K &>/dev/null

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

docker pull ghcr.io/ruby/all-ruby
docker pull --platform=linux/amd64 rubylang/all-ruby
# docker run --rm -it quay.io/podman/hello

## lima

limactl start default

(cd ~/s/github.com/znz/ansible-playbook-2022 && git pull --rebase --autostash --prune && rake lima:all)

## brew

# brew upgrade

# brew services start syncthing

# brew services start ollama
# brew services stop ollama

# launchctl unload ~/Library/LaunchAgents/com.zabbix.agentd.plist
# launchctl load -w ~/Library/LaunchAgents/com.zabbix.agentd.plist

## rust

rustup update

## anyenv

anyenv update

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

## URLs
