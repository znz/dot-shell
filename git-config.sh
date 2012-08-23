#!/bin/sh
cd "$(dirname "$0")"
set -ex
#git config --global user.name "$DEBFULLNAME"
#git config --global user.email "$DEBEMAIL"
git config --global core.excludesfile "$(pwd)/gitignore"
#git config --global color.branch auto
#git config --global color.diff auto
#git config --global color.interactive auto
#git config --global color.status auto
git config --global color.ui auto
git config --global svn.rmdir true
#git config --global push.default simple
git config --global push.default tracking
