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
if [ "$(lsb_release -cs)" = "precise" ]; then
    git config --global push.default tracking
else
    git config --global push.default simple
fi

# github upload
GITHUB_URL_PREFIX="url.git@github.com:"
git config --global --remove-section "$GITHUB_URL_PREFIX" || :
git config --global       "$GITHUB_URL_PREFIX".pushInsteadOf "git://github.com/"
git config --global --add "$GITHUB_URL_PREFIX".pushInsteadOf "https://github.com/"
# gist upload
github_user="$(git config github.user || :)"
if [ -n "$github_user" ]; then
    git config --global "url.git@gist.github.com:".pushInsteadOf "https://gist.github.com/$github_user/"
    git config --global ghq.user "$github_user"
fi
# github download
#git config --global url."git://github.com/".insteadOf "https://github.com/"
#git config --global --unset url."git://github.com/".insteadOf || :
git config --global --remove-section url."git://github.com/" || :
git config --global url."https://github.com/".insteadOf "git://github.com/"

# ghq section
git config --global --remove-section "ghq" || :
GHQ_ROOT="ghq.root"
git config --global --unset-all "$GHQ_ROOT" || :
git config --global       "$GHQ_ROOT" "$HOME/go/src"
git config --global --add "$GHQ_ROOT" "$HOME/s"

git config --global init.templatedir "$(pwd)/git-templates"
git config --global core.attributesfile "$(pwd)/gitattributes"

git config --global commit.gpgsign true
