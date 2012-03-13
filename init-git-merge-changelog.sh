#!/bin/sh
# see http://d.hatena.ne.jp/nurse/20100413

# set .gitattributes
# echo "ChangeLog merge=merge-changelog" >> .git/info/attributes

: ${TMPDIR:=/tmp}
set -ex
cd "$TMPDIR"

if [ ! -d gnulib ]; then
    git clone --depth 1 git://git.sv.gnu.org/gnulib.git
fi
cd gnulib

PREFIX="$HOME/opt/gnulib"
DRIVER="$PREFIX/bin/git-merge-changelog"

if [ ! -x "$DRIVER" ]; then
    ./gnulib-tool --create-testdir --dir="$TMPDIR/testdir123" git-merge-changelog
    cd "$TMPDIR/testdir123"
    ./configure --prefix="$PREFIX"
    make
    make install
fi

git config --global merge.merge-changelog.name "GNU-style ChangeLog merge driver"
git config --global merge.merge-changelog.driver "$DRIVER %O %A %B"
