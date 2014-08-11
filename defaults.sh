#!/bin/sh
set -ex
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
# http://support.apple.com/kb/HT1629?viewlocale=ja_JP
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
