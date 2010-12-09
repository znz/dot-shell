#!/bin/sh
set -e

# Debian
DIST_LIST="$DIST_LIST etch"
DIST_LIST="$DIST_LIST lenny"
DIST_LIST="$DIST_LIST squeeze"
DIST_LIST="$DIST_LIST sid"
# Ubuntu
DIST_LIST="$DIST_LIST hardy"
DIST_LIST="$DIST_LIST karmic"
DIST_LIST="$DIST_LIST lucid"
DIST_LIST="$DIST_LIST maverick"

cd "$(dirname "$0")"
RC_DIR="$(pwd)"
RC_FILE="$RC_DIR/pbuilderrc"
: ${ARCH:="$(dpkg --print-architecture)"}

V () {
    echo "$@"
    "$@"
}

case "$1" in
    create)
	for dist in $DIST_LIST; do
	    if [ ! -f /var/cache/pbuilder/$dist-$ARCH-base.tgz ]; then
		V sudo DIST=$dist pbuilder create --configfile "$RC_FILE" --debootstrapopts --variant=buildd
	    fi
	done
	;;
    update)
	for dist in $DIST_LIST; do
	    if [ -f /var/cache/pbuilder/$dist-$ARCH-base.tgz ]; then
		V sudo DIST=$dist pbuilder create --configfile "$RC_FILE"
	    fi
	done
	;;
    symlink)
	if [ -e $HOME/.pbuilderrc ]; then
	    echo "$HOME/.pbuilderrc already exists"
	    exit 1
	fi
	V ln -s "$RC_FILE" "$HOME/.pbuilderrc"
	;;
    *)
	echo "usage: $0 {create|update|symlink}"
	echo "build: DIST=etch pdebuild --configfile $RC_FILE"
	echo "result: ls -al /var/cache/pbuilder/etch-i386/result/"
	;;
esac
