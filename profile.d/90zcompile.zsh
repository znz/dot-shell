#!/bin/zsh
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   compile ~/.zshrc
fi
