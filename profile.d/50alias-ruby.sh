rspec () {
    if [ -d .bundle ]; then
        bundle exec rspec "$@"
    else
        command rspec "$@"
    fi
}
