my_create_cachedir_tag () {
    local application_name="$1"
    local cachedir="$2"
    local tag="$cachedir/CACHEDIR.TAG"
    if [ ! -d "$cachedir" ]; then
	echo "my_create_cachedir_tag: $cachedir is not directory" 1>&2
    elif [ ! -f "$tag" ]; then
	echo "my_create_cachedir_tag: create $tag for $application_name" 1>&2
	{
	    echo "Signature: 8a477f597d28d172789f06886806bc55"
	    echo "# This file is a cache directory tag created by $application_name"
	    echo "# For information about cache directory tags, see:"
	    echo "#   http://www.brynosaurus.com/cachedir/"
	} >"$tag"
    fi
}

if [ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/shell" ]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
    my_create_cachedir_tag "10cache.sh" "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
fi
