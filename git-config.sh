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

# github upload
GITHUB_URL_PREFIX="url.git@github.com:"
git config --global --remove-section "$GITHUB_URL_PREFIX" || :
git config --global       "$GITHUB_URL_PREFIX".pushInsteadOf "git://github.com/"
git config --global --add "$GITHUB_URL_PREFIX".pushInsteadOf "https://github.com/"
# gist upload
git config --global "url.git@gist.github.com:".pushInsteadOf "https://gist.github.com/$(git config github.user)/"
# github download
git config --global url."git://github.com/".insteadOf "https://github.com/"

# ghq section
git config --global --remove-section "ghq" || :
GHQ_ROOT="ghq.root"
#git config --global --unset-all "$GHQ_ROOT" || :
git config --global       "$GHQ_ROOT" "$HOME/s"
git config --global --add "$GHQ_ROOT" "$HOME/g/src"

git config --global init.templatedir "$(pwd)/git-templates"
