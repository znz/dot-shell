#!/bin/sh
cd "$(dirname "$0")"
DIR="$(pwd)"
set -ex
cd
if [ -d .rbenv ]; then
    cd .rbenv
    git pull
else
    git clone git://github.com/sstephenson/rbenv.git .rbenv
fi

cd
mkdir -p .rbenv/plugins
cd .rbenv/plugins
if [ -d ruby-build ]; then
    cd ruby-build
    git pull
else
    git clone git://github.com/sstephenson/ruby-build.git
fi
