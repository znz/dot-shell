#!/bin/sh
cd "$(dirname "$0")"
DIR="$(pwd)"
set -ex
cd
if [ -d .rbenv ]; then
    cd .rbenv
    if [ -d .git ]; then
        git pull
    fi
else
    git clone git://github.com/sstephenson/rbenv.git .rbenv
fi

cd
mkdir -p .rbenv/plugins
cd .rbenv/plugins
if [ -d ruby-build ]; then
    cd ruby-build
    git pull
    cd ..
else
    git clone git://github.com/sstephenson/ruby-build.git
fi

if [ -L /etc/alternatives/ruby ]; then
    if [ -d rbenv-alternatives ]; then
        cd rbenv-alternatives
        git pull
        cd ..
    else
        git clone git://github.com/terceiro/rbenv-alternatives.git
    fi
fi
