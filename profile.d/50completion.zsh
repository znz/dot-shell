#!/bin/zsh
autoload -U compinit
if [ x$OSTYPE = xcygwin ]; then
    my_compinit () {
        compinit -u "$@"
    }
else
    my_compinit () {
        compinit "$@"
    }
fi
if [ -d "${XDG_CACHE_HOME:-$HOME/.cache}/shell" ]; then
    my_compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/shell/$HOST.zcompdump"
else
    my_compinit
fi

# http://pc5.2ch.net/test/read.cgi/unix/1080002786/516-518n
# 補完候補から.svnを除く。
# .で始まるディレクトリが候補になっていなかったのでコメントアウトしていたが、
# .で始まる補完の場合に出ていたので有効に。
zstyle ':completion:*:*:*:*' ignored-patterns '.svn'

# Prevent CVS files/directories from being completed:
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
#zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# Ignoring lost+found directories
#zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found'

# merged
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#(CVS|lost+found)'


#_ignored_patterns_users_caching_policy () {
#    # rebuild if cache is more than a week old
#    local -a oldp
#    oldp=( "$1"(Nmw+1) )
#    (( $#oldp )) && return 0
#    [[ /etc/passwd -nt "$1" ]]
#}
#_ignored_patterns_users () {
#    local update_policy
#    zstyle -s ":completion:$curcontext:" cache-policy update_policy
#    if [[ -z "$update_policy" ]]; then
#        zstyle ":completion:$curcontext:" cache-policy _ignored_patterns_users_caching_policy
#    fi
#
#    if ( [[ ${+_ignored_patterns_users} -eq 0 ]] || _cache_invalid ignored_patterns_users ) && ! _retrieve_cache ignored_patterns_users; then
#    # see http://www.debian.org/doc/debian-policy/ch-opersys.html for range of user-ids
#        typeset -aU _ignored_patterns_users
#        if [ -x /usr/bin/getent ]; then
#            _ignored_patterns_users=(
#                ${(f)"$(/usr/bin/getent passwd | awk -F: '$3<1000||$3>30000{if($1!="root"){print $1}}')"}
#            )
#        else
#            _ignored_patterns_users=(
#                ${(f)"$(awk -F: '$3<1000||$3>30000{if($1!="root"){print $1}}' /etc/passwd)"}
#            )
#        fi
#        _store_cache ignored_patterns_users _ignored_patterns_users
#    fi
#    reply=($_ignored_patterns_users)
#}
#zstyle -e ':completion:*:*:*:users' ignored-patterns _ignored_patterns_users

# users completer add lots of uninteresting user accounts, remove them
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup bind \
    dictd gnats identd irc man messagebus postfix proxy sys www-data

# Ignore completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Ignore parent directory
# Useful for cd, mv and cp. Ex, cd will never select the parent directory (ie cd ../<TAB>):
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd

# Ignore what's already in the line
# With commands like `rm/kill/diff' it's annoying if one gets offered the same filename again even if it is already on the command line. To avoid that:
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

if is_cygwin; then
    zstyle ':completion:*:commands' ignored-patterns '*.(#i)(AX|BAK|BMP|DAT|DRV|DLL|EXE|IME|INF|INI|LA|LHP|LOG|LRC|MANIFEST|MFL|MOF|NLS|OCX|OLD|TLB|TXT|SCF|SWP|SYS|TMP)' '*Uninstall*' '*\~' '.cvsignore'
else
    zstyle ':completion:*:commands' ignored-patterns '*.(#i)(BAK|SWP)' '*\~' '.cvsignore'
fi
