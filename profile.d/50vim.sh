if [ -n "$XDG_CONFIG_HOME" ] && [ ! -f "$XDG_CONFIG_HOME/vim/vimrc" ]; then
    mkdir -p "$XDG_CONFIG_HOME/vim"
    # from https://wiki.archlinux.jp/index.php/XDG_Base_Directory
    cat >"$XDG_CONFIG_HOME/vim/vimrc" <<'EOF'
set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_DATA_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after

set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

let g:netrw_home = $XDG_DATA_HOME."/vim"
call mkdir($XDG_DATA_HOME."/vim/spell", 'p')
set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p')

set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p')
set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p')
set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p')

if !has('nvim') | set viminfofile=$XDG_CACHE_HOME/vim/viminfo | endif
EOF

    # migration
    if [ ! -f "$XDG_CACHE_HOME/vim/viminfo" ] && [ -f "$HOME/.viminfo" ]; then
        mkdir -p "$XDG_CACHE_HOME/vim"
	mv "$HOME/.viminfo" "$XDG_CACHE_HOME/vim/viminfo"
    fi
fi
