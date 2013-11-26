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

GITHUB_URL_PREFIX="url.git@github.com:"
git config --global --remove-section "$GITHUB_URL_PREFIX" || :
git config --global       "$GITHUB_URL_PREFIX".pushInsteadOf "git://github.com/"
git config --global --add "$GITHUB_URL_PREFIX".pushInsteadOf "https://github.com/"
# git/contrib/diff-highlight
if type diff-highlight >/dev/null 2>&1; then
  git config --global pager.log  'diff-highlight | $PAGER'
  git config --global pager.show 'diff-highlight | $PAGER'
  git config --global pager.diff 'diff-highlight | $PAGER'
fi
